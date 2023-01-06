#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule RDFGraph.Examples.WalkLinks do
  use Tesla

  plug Tesla.Middleware.FollowRedirects, max_redirects: 3
  plug Tesla.Middleware.Headers, [{"accept", "text/turtle"}]

  def walk_links(link \\ "http://dbpedia.org/resource/Bob_Dylan", count \\ 0)
  def walk_links(_, count) when count >= 7, do: :ok

  def walk_links(link, count) do
    IO.puts link    
    {:ok, result} = get(link)   
    id = String.slice(link, 28..-1)
    RDFGraph.write_graph(result.body, "walk/" <> id <> ".ttl")
    graph = RDF.Turtle.read_string!(result.body)   
    query = ~S"""
      PREFIX dbo: <http://dbpedia.org/ontology/>
      SELECT DISTINCT ?new_link
      WHERE
      {
        BIND (<LINK> AS ?link)
        ?link dbo:wikiPageWikiLink ?new_link
      }
    """
    query = String.replace(query, "LINK", link)
    list = SPARQL.execute_query(graph, query) |>    
             SPARQL.Query.Result.get(:new_link)
    if Enum.empty?(list) do
      :ok
    else
      link = Enum.random(list) |> RDF.IRI.to_string
      walk_links(link, count + 1)
    end
  end

end
