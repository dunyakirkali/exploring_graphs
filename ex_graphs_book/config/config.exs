#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
import Config

config :graph_commons, root_dir: File.cwd!

config :tzdata, :autoupdate, :disabled

## D_GRAPH

#  -

## PROPERTY_GRAPH

config :bolt_sips, Bolt,
  url: "bolt://neo4j:neo4jtest@localhost:7687", timeout: 30_000

## RDF_GRAPH

# HTTP client

config :tesla, adapter: Tesla.Adapter.Hackney

# RDF database access

config :rdf_graph,
  cur_graph_store: :local,
  graph_store: %{
    local: %{
      admin: "http://localhost:7200/repositories/ex-graphs-book/rdf-graphs/"
             <> "service?default",
      query: "http://localhost:7200/repositories/ex-graphs-book",
      update: "http://localhost:7200/repositories/ex-graphs-book/statements"
    },
    dbpedia: %{
      admin: nil,
      query: "https://dbpedia.org/sparql",
      update: nil
    },
    wikidata: %{
      admin: nil,
      query: "https://query.wikidata.org/bigdata/namespace/wdq/sparql",
      update: nil
    }
  }

## TINKER_GRAPH

config :gremlex,
  host: "127.0.0.1",
  port: 8182,
  path: "/gremlin",
  pool_size: 10,
  secure: false,
  ping_delay: 90_000

# For loading per app config files
# for config <- "apps/*/config/config.exs" |> Path.expand() |> Path.wildcard() do
#   import_config config
# end
