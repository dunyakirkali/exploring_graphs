#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCompute.ProcessGraph do

  def graph_up(%Graph{} = g) do
    h = Graph.new()
    m = Map.new()

    # vertices (1)
    h =
      g
      |> Graph.vertices()
      |> Enum.reduce(h, fn v, h ->
        p = GraphCompute.Application.genserver()
        GraphCompute.Process.put(p, :id, v)
        Graph.add_vertex(h, p)
      end)

    # map (vertex ID -> PID ) (2)
    m =
      h
      |> Graph.vertices()
      |> Enum.reduce(m, fn p, m ->
        v = GraphCompute.Process.get(p, :id)
        Map.put(m, v, p)
      end)

    # edges (3)
    h =
      g
      |> Graph.edges()
      |> Enum.reduce(h, fn e, h ->
        %Graph.Edge{label: label, v1: v1, v2: v2, weight: _} = e
        Graph.add_edge(h, Map.get(m, v1), Map.get(m, v2), label: label)
      end)

    # graph (4)
    GraphCompute.Graph.update(h)
    h
  end

  def get_state(p) do
    GraphCompute.Process.get(p)
  end

  def put_state(p, {name, value}) do
    GraphCompute.Process.put(p, name, value)
  end

end
