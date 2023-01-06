#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule RDFGraph.Service do
  @behaviour GraphCommons.Service

  @sparql_count_nodes """
  SELECT (count(DISTINCT ?vertex) AS ?total)
  WHERE
  {
    { ?vertex ?p [] }
    UNION
    {
      [] ?p ?vertex
      FILTER(!IsLiteral(?vertex))
    }
  }
  """

  @sparql_count_edges """
  SELECT (count(?vertex) AS ?total)
  WHERE
  {
    ?vertex ?edge []
  }
  """

  @sparql_list_types """
  SELECT distinct ?type
  WHERE
  {
    ?vertex a ?type
  }
  """

  ## STORE

  def rdf_store do
    Application.get_env(:rdf_graph, :rdf_store)
  end
  def rdf_store(store) do
    Application.put_env(:rdf_graph, :rdf_store, store )
  end

  def list_rdf_stores do
    Map.keys Application.get_env(:rdf_graph, :graph_store)
  end

  def rdf_store_admin do
    store = rdf_store()
    Application.get_env(:rdf_graph, :graph_store)[store][:admin]
  end
  def rdf_store_query do
    store = rdf_store()
    Application.get_env(:rdf_graph, :graph_store)[store][:query]
  end
  def rdf_store_update do
    store = rdf_store()
    Application.get_env(:rdf_graph, :graph_store)[store][:update]
  end

  ## GRAPH

  def graph_create(%GraphCommons.Graph{} = graph) do
    if rdf_store_admin() do
      graph_delete()
      graph_update(graph)
    else
      {:error, rdf_store()}
    end
  end

  def graph_delete() do
    if rdf_store_admin() do
      {:ok, env} = Tesla.delete(rdf_store_admin())
      GraphCommons.Graph.new(env.body, "", :rdf)
      env
    else
      {:error, rdf_store()}
    end
  end

  def graph_read() do
    if rdf_store_admin() do
      {:ok, env} = Tesla.get(rdf_store_admin())
      GraphCommons.Graph.new(env.body, "", :rdf)
    else
      {:error, rdf_store()}
    end
  end

  def graph_update(%GraphCommons.Graph{} = graph) do
    if rdf_store_admin() do
      {:ok, env} = Tesla.post(rdf_store_admin(),
                     graph.data, headers: [{"content-type", "text/turtle"}])
      GraphCommons.Graph.new(env.body, "", :rdf)
    else
      {:error, rdf_store()}
    end
  end

  def graph_info() do
    import RDFGraph, only: [new_query: 1]
    if rdf_store_admin() do

      {:ok, %SPARQL.Query.Result{results: [%{"total" => total}]}} =
        @sparql_count_nodes
        |> new_query
        |> query_graph

      nodes = RDF.Literal.value(total)

      {:ok, %SPARQL.Query.Result{results: [%{"total" => total}]}} =
        @sparql_count_edges
        |> new_query
        |> query_graph

      edges = RDF.Literal.value(total)

      {:ok, %SPARQL.Query.Result{results: types}} =
        @sparql_list_types
        |> new_query
        |> query_graph

      labels =
        types
        |> Enum.map(fn t ->
          %{"type" => type} = t
          URI.parse(type.value).path |> Path.basename
        end)
        |> Enum.sort

      %GraphCommons.Service.GraphInfo{
        type: :rdf,
        file: "",
        num_nodes: nodes,
        num_edges: edges,
        labels: labels
      }
    else
      {:ok, rdf_store()}
    end
  end

  ## QUERY

  def query_graph(%GraphCommons.Query{} = query, params \\ []) do
    :rdf = query.type
    SPARQL.Client.query(query.data, rdf_store_query(), params)
  end

  def query_graph!(%GraphCommons.Query{} = query, params \\ []) do
    :rdf = query.type

    update = Keyword.has_key?(params, :update) && Keyword.get(params, :update)

    unless update do
      SPARQL.Client.query(query.data, rdf_store_query(), params)
        |> case do
          {:ok, response} -> response
          {:error, message} -> raise "! #{message}"
        end
    else
      SPARQL.Client.update(query.data, rdf_store_update(), raw_mode: true)
        |> case do
          :ok -> :ok
          {:error, message} -> raise "! #{message}"
        end
    end

  end

end
