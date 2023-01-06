#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule TinkerGraph do

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :tinker, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :tinker, query_module: __MODULE__

  ## GRAPH SERVICE

  defdelegate graph_create(arg), to: TinkerGraph.Service, as: :graph_create
  defdelegate graph_delete(), to: TinkerGraph.Service, as: :graph_delete
  defdelegate graph_info(), to: TinkerGraph.Service, as: :graph_info
  # defdelegate graph_read(), to: TinkerGraph.Service, as: :graph_read
  defdelegate graph_update(arg), to: TinkerGraph.Service, as: :graph_update

  defdelegate query_graph(arg), to: TinkerGraph.Service, as: :query_graph
  defdelegate query_graph!(arg), to: TinkerGraph.Service, as: :query_graph!

end
