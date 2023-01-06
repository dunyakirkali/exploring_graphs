#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule TinkerGraph.Service do
  @behaviour GraphCommons.Service
  # import GraphCommons.Utils, only: [eval: 1]

  ## GRAPH

  def graph_create(graph) do
    graph_delete()
    graph_update(graph)
  end

  def graph_delete() do
    Gremlex.Client.query("g.V().drop()")
  end

  def graph_read() do
  end

  def graph_update(%GraphCommons.Graph{type: :tinker} = graph) do
    Gremlex.Client.query(graph.data)
  end

  ## INFO

  def graph_info() do
    {:ok, [num_vertices]} = Gremlex.Client.query("g.V().count()")
    {:ok, vertex_labels} = Gremlex.Client.query("g.V().label().dedup()")
    {:ok, [num_edges]} = Gremlex.Client.query("g.E().count()")
    {:ok, edge_labels} = Gremlex.Client.query("g.E().label().dedup()")

    %GraphCommons.Service.GraphInfo{
      type: :tinker,
      num_nodes: num_vertices,
      num_edges: num_edges,
      labels: vertex_labels ++ edge_labels
    }
  end

  ## QUERY

  def query_graph(%GraphCommons.Query{type: :tinker} = query) do
    Gremlex.Client.query(query.data)
  end

  def query_graph!(%GraphCommons.Query{type: :tinker} = query) do
    Gremlex.Client.query(query.data)
    |>
    case do
      {:ok, response} -> response
      {:error, message} -> raise "! #{message}"
    end
  end

end
