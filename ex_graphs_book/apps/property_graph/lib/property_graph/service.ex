#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule PropertyGraph.Service do
  @behaviour GraphCommons.Service

  @cypher_delete """
  MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r
  """

  @cypher_read """
  MATCH (n) OPTIONAL MATCH (n)-[r]-() RETURN DISTINCT n, r
  """

  @cypher_info """
  CALL apoc.meta.stats()
  YIELD labels, labelCount, nodeCount, relCount, relTypeCount
  """

  ## GRAPH

  def graph_create(graph) do
    graph_delete()
    graph_update(graph)
  end

  def graph_delete(), do: Bolt.Sips.query!(Bolt.Sips.conn(), @cypher_delete)

  def graph_read(), do: Bolt.Sips.query!(Bolt.Sips.conn(), @cypher_read)

  def graph_update(%GraphCommons.Graph{} = graph),
    do: Bolt.Sips.query!(Bolt.Sips.conn(), graph.data)

  def graph_info() do
    {:ok, [stats]} =
      @cypher_info
      |> PropertyGraph.new_query()
      |> query_graph

    %GraphCommons.Service.GraphInfo{
      type: :property,
      file: "",
      num_nodes: stats["nodeCount"],
      num_edges: stats["relCount"],
      labels: Map.keys(stats["labels"])
    }
  end

  ## QUERY

  def query_graph(%GraphCommons.Query{} = query), do: query_graph(query, %{})

  def query_graph(%GraphCommons.Query{} = query, params) do
    :property = query.type

    Bolt.Sips.query(Bolt.Sips.conn(), query.data, params)
    |> case do
      {:ok, response} -> parse_response(response, false)
      {:error, error} -> {:error, error}
    end
  end

  def query_graph!(%GraphCommons.Query{} = query), do: query_graph!(query, %{})

  def query_graph!(%GraphCommons.Query{} = query, params) do
    :property = query.type

    Bolt.Sips.query(Bolt.Sips.conn(), query.data, params)
    |> case do
      {:ok, response} -> parse_response(response, true)
      {:error, error} -> raise "! #{inspect error}"
    end
  end

  # 
  # def query_graph!(%GraphCommons.Query{} = query, param \\ %{}) do
  #   :property = query.type
  #
  #   Bolt.Sips.query(Bolt.Sips.conn(), query.data, param)
  #   |> case do
  #     {:ok, response} -> parse_response(response, false)
  #     {:error, error} -> {:error, error}
  #   end
  # end
  # 

  defp parse_response(%Bolt.Sips.Response{} = response, bang) do
    %Bolt.Sips.Response{type: type} = response

    case type do
      r when r in ["r", "rw"] ->
        %Bolt.Sips.Response{results: results} = response
        unless bang, do: {:ok, results}, else: results
      s when s in ["s"] ->
        %Bolt.Sips.Response{results: results} = response
        unless bang, do: {:ok, results}, else: results
      w when w in ["w"] ->
        %Bolt.Sips.Response{stats: stats} = response
        unless bang, do: {:ok, stats}, else: stats
    end
  end

end
