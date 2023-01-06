#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule RDFGraph do

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :rdf, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :rdf, query_module: __MODULE__

  ## GRAPH SERVICE

  defdelegate graph_create(arg), to: RDFGraph.Service, as: :graph_create
  defdelegate graph_delete(), to: RDFGraph.Service, as: :graph_delete
  defdelegate graph_info(), to: RDFGraph.Service, as: :graph_info
  defdelegate graph_read(), to: RDFGraph.Service, as: :graph_read
  defdelegate graph_update(arg), to: RDFGraph.Service, as: :graph_update

  defdelegate query_graph(arg), to: RDFGraph.Service, as: :query_graph
  defdelegate query_graph!(arg), to: RDFGraph.Service, as: :query_graph!

  defdelegate query_graph(arg, params), to: RDFGraph.Service, as: :query_graph
  defdelegate query_graph!(arg, params), to: RDFGraph.Service, as: :query_graph!

  defdelegate rdf_store(), to: RDFGraph.Service, as: :rdf_store
  defdelegate rdf_store(arg), to: RDFGraph.Service, as: :rdf_store
  defdelegate list_rdf_stores(), to: RDFGraph.Service, as: :list_rdf_stores
  defdelegate rdf_store_admin(), to: RDFGraph.Service, as: :rdf_store_admin
  defdelegate rdf_store_query(), to: RDFGraph.Service, as: :rdf_store_query
  defdelegate rdf_store_update(), to: RDFGraph.Service, as: :rdf_store_update

end
