#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule RDFGraph.Examples.WalkQuery do

  def walk_query(link \\ "http://dbpedia.org/resource/Bob_Dylan", count \\ 0)    
  def walk_query(_, count) when count >= 7, do: :ok    

  def walk_query(link, count) do
    IO.puts link
    query =     
    ~S"""
      PREFIX dbo: <http://dbpedia.org/ontology/>
      SELECT DISTINCT ?new_link
      WHERE
      {
        BIND (<LINK> AS ?link)
        ?link dbo:wikiPageWikiLink ?new_link
      }
    """
    query = String.replace(query, "LINK", link)    
    store = RDFGraph.Service.rdf_store_query()    
    list = with {:ok, result} = SPARQL.Client.query(query, store),    
           do: SPARQL.Query.Result.get(result, :new_link)
    if Enum.empty?(list) do   
      :ok
    else
      link = Enum.random(list) |> RDF.IRI.to_string
      walk_query(link, count + 1)
    end
  end

end
