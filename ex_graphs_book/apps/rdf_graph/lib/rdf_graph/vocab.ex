#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule RDFGraph.Vocab do
  use RDF.Vocabulary.Namespace

  defvocab(SCHEMA,
    base_iri: "https://schema.org/",
    terms: ~w[
      Book Organization Person
      author book bookFormat datePublished
      identifier isbn name publisher
    ]
  )

  ## book function defintions

  def book() do

    import RDF.Sigils

    [
      ~I<https://pragprog.com/titles/tvmelixir/adopting-elixir/>
      |> RDF.type(SCHEMA.Book)
      |> SCHEMA.author(
        ~I<https://twitter.com/bgmarx>,
        ~I<https://twitter.com/josevalim>,
        ~I<https://twitter.com/redrapids>
      )
      |> SCHEMA.datePublished("2018-03-14")
      |> SCHEMA.bookFormat(~L"Paperback")
      |> SCHEMA.identifier(~L"adopting_elixir")
      |> SCHEMA.isbn(~L"978-1-68050-252-7")
      |> SCHEMA.publisher(~I<https://pragprog.com/>)
      |> SCHEMA.name(~L"Adopting Elixir"),

      ~I<https://pragprog.com/>
      |> RDF.type(SCHEMA.Organization)
      |> SCHEMA.identifier(~L"pragmatic")
      |> SCHEMA.name(~L"The Pragmatic Bookshelf"),

      ~I<https://twitter.com/bgmarx>
      |> RDF.type(SCHEMA.Person)
      |> SCHEMA.identifier(~L"ben_marx")
      |> SCHEMA.name(~L"Ben Marx"),

      ~I<https://twitter.com/josevalim>
      |> RDF.type(SCHEMA.Person)
      |> SCHEMA.identifier(~L"jose_valim")
      |> SCHEMA.name(~L"José Valim"),

      ~I<https://twitter.com/redrapids>
      |> RDF.type(SCHEMA.Person)
      |> SCHEMA.identifier(~L"bruce_tate")
      |> SCHEMA.name(~L"Bruce Tate")
    ]

  end

end
