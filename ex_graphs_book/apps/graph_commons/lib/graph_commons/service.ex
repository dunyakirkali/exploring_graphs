#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCommons.Service do

  @optional_callbacks graph_info: 0
  @optional_callbacks query_graph: 2
  @optional_callbacks query_graph!: 2

  ## GRAPH
  @callback graph_create(GraphCommons.Graph.t()) :: any()
  @callback graph_delete() :: any()
  @callback graph_info() :: any()
  @callback graph_read() :: any()
  @callback graph_update(GraphCommons.Graph.t()) :: any()

  ## QUERY
  @callback query_graph(GraphCommons.Query.t()) :: any()
  @callback query_graph!(GraphCommons.Query.t()) :: any()
  @callback query_graph(GraphCommons.Query.t(), map()) :: any()
  @callback query_graph!(GraphCommons.Query.t(), map()) :: any()
  
end
