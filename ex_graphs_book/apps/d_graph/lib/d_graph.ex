#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule DGraph do

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :dgraph, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :dgraph, query_module: __MODULE__

  ## GRAPH SERVICE

  defdelegate graph_create(arg), to: DGraph.Service, as: :graph_create
  defdelegate graph_delete(), to: DGraph.Service, as: :graph_delete
  defdelegate graph_info(), to: DGraph.Service, as: :graph_info
  # defdelegate graph_read(), to: DGraph.Service, as: :graph_read
  defdelegate graph_update(arg), to: DGraph.Service, as: :graph_update

  defdelegate query_graph(arg), to: DGraph.Service, as: :query_graph
  defdelegate query_graph!(arg), to: DGraph.Service, as: :query_graph!

  defdelegate schema_update(arg), to: DGraph.Service, as: :schema_update

end
