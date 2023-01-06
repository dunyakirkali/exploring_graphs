#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCommons.Utils do

  defguard is_module(graph_module)
    when graph_module in [DGraph, NativeGraph, PropertyGraph, RDFGraph,
    TinkerGraph]

  defmacro graph_context(graph_module) do
    quote do
      # unimport any existing graph modules
      import DGraph, only: []
      import NativeGraph, only: []
      import PropertyGraph, only: []
      import RDFGraph, only: []
      import TinkerGraph, only: []
      # import graph module argument
      import unquote(graph_module)
    end
  end

  ## QUERY HELPERS

  defp to_query_graph!(graph_module, query_string)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph!()
  end

  defp to_query_graph!(graph_module, query_string, query_params)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph!(query_params)
  end

  defp to_query_graph(graph_module, query_string)
       when is_module(graph_module) do
    query_string
    |> graph_module.new_query()
    |> graph_module.query_graph()
  end

  def cypher!(query_string), do: to_query_graph!(PropertyGraph, query_string)

  def cypher!(query_string, query_params),
    do: to_query_graph!(PropertyGraph, query_string, query_params)

  def dgraph!(query_string), do: to_query_graph(DGraph, query_string)

  def gremlin!(query_string), do: to_query_graph!(TinkerGraph, query_string)

  def sparql!(query_string), do: to_query_graph!(RDFGraph, query_string)

  def sparql!(query_string, query_params),
    do: to_query_graph!(RDFGraph, query_string, query_params)

  def sparql_update!(query_string, query_params \\ []),
    do: to_query_graph!(RDFGraph, query_string,
        Keyword.put(query_params, :update, true))

end
