#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule DGraph.Service do
  @behaviour GraphCommons.Service

  def get_pid() do
     Application.get_env(:dlex, PID)
  end

  ## GRAPH

  def graph_create(graph) do
    graph_delete()
    graph_update(graph)
  end

  def graph_delete() do
    Dlex.alter!(DGraph.Service.get_pid(), %{drop_all: true})
  end

  def graph_read() do
    #
  end

  def graph_update(%GraphCommons.Graph{} = graph) do
    Dlex.mutate(DGraph.Service.get_pid(), %{set: graph.data})
  end

  def graph_info() do
    %GraphCommons.Service.GraphInfo{
      type: :dgraph,
      # num_nodes: num_vertices,
      # num_edges: num_edges,
      # labels: vertex_labels ++ edge_labels
    }
  end

  def schema_update(%GraphCommons.Graph{} = graph) do
    Dlex.alter(DGraph.Service.get_pid(), graph.data)
  end

  ## QUERY

  def query_graph(%GraphCommons.Query{} = query) do
    :dgraph = query.type

    Dlex.query(DGraph.Service.get_pid(), query.data)
    |> case do
      {:ok, response} -> response
      {:error, error} -> raise "! #{inspect error}"
    end
  end

  def query_graph!(%GraphCommons.Query{} = query) do
    :dgraph = query.type

    Dlex.query(DGraph.Service.get_pid(), query.data)
    |> case do
      {:ok, response} -> response
      {:error, error} -> raise "! #{inspect error}"
    end
  end

end
