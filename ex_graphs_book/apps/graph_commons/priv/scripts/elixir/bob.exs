#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
import GraphCommons.Utils, only: [sparql!: 1]
import RDFGraph, only: [rdf_store: 1, write_graph: 2]

# query :dbpedia
rdf_store :dbpedia
bob1 = "DESCRIBE <http://dbpedia.org/resource/Bob_Dylan>" |> sparql!

# query :wikidata
rdf_store :wikidata
bob2 = "DESCRIBE <http://www.wikidata.org/entity/Q392>" |> sparql!

# write to graph store
bob1_graph = (RDF.Turtle.write_string! bob1) |> write_graph("bob1.ttl")
bob2_graph = (RDF.Turtle.write_string! bob2) |> write_graph("bob2.ttl")

# write graph merge to graph store
(bob1_graph.data <> bob2_graph.data) |> write_graph("bob.ttl")
