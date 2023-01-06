#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
import GraphCommons
import GraphCommons.Utils ; alias GraphCommons.Utils

IEx.configure(default_prompt: "%prefix>", alive_prompt: "%prefix>")

GraphCommons.hello()

graph_context DGraph

# # graph_context NativeGraph
# graph_context RDFGraph
# 
# RDFGraph.rdf_store :dbpedia
# # import RDFGraph.Examples.WalkQuery
# import RDFGraph.Examples.WalkLinks
# 
# # import GraphCompute.ProcessGraph
# 
# # c "/Users/tony/Book/Code/priv/scripts/elixir/arpa.exs"
# 
# # alias RDFGraph.Vocab.SCHEMA
# 
# # graph_context TinkerGraph
# # alias Gremlex.{Graph,Client}
# 
# # "books.graph" |> NativeGraph.read_graph |> NativeGraph.graph_create
