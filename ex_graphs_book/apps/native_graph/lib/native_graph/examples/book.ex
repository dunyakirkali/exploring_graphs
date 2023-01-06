#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule NativeGraph.Examples.Book do

  def book(use_id? \\ true), do: do_books(false, use_id?)
  def books(use_id? \\ true), do: do_books(true, use_id?)

  defp do_books(all_books?, use_id?) do
    # function to select id/map based on use_id? setting
    val = fn map -> if use_id?, do: map.id, else: map end

    # book 1
    bk1 =
      val.(%{
        id: :adopting_elixir,
        date: "2018-03-14",
        format: "Paper",
        isbn: "978-1-68050-252-7",
        title: "Adopting Elixir",
        url: "https://pragprog.com/titles/tvmelixir/adopting-elixir/"
      })

    bk1_au1 =
      val.(%{
        id: :ben_marx,
        name: "Ben Marx",
        url: "https://twitter.com/bgmarx"
      })

    bk1_au2 =
      val.(%{
        id: :jose_valim,
        name: "José Valim",
        url: "https://twitter.com/josevalim"
      })

    bk1_au3 =
      val.(%{
        id: :bruce_tate,
        name: "Bruce Tate",
        url: "https://twitter.com/redrapids"
      })

    bk1_pub =
      val.(%{
        id: :pragmatic,
        name: "The Pragmatic Bookshelf",
        url: "https://pragprog.com/"
      })

    # book 2
    bk2 =
      val.(%{
        id: :graphql_apis,
        date: "2018-03-27",
        format: "Paper",
        isbn: "978-1-68050-255-8",
        title: "Craft GraphQL APIs in Elixir with Absinthe",
        url: "https://pragprog.com/titles/wwgraphql/craft-graphql-apis-in-elixir-with-absinthe/"
      })

    bk2_au1 =
      val.(%{
        id: :bruce_williams,
        name: "Bruce Williams",
        url: "https://twitter.com/wbruce"
      })

    bk2_au2 =
      val.(%{
        id: :ben_wilson,
        name: "Ben Wilson",
        url: "https://twitter.com/benwilson512"
      })

    bk2_pub =
      val.(%{
        id: :pragmatic,
        name: "The Pragmatic Bookshelf",
        url: "https://pragprog.com/"
      })

    # book 3
    bk3 =
      val.(%{
        id: :designing_elixir,
        date: "2019-11-20",
        format: "Paper",
        isbn: "978-1-68050-661-7",
        title: "Designing Elixir Systems with OTP",
        url: "https://pragprog.com/titles/jgotp/designing-elixir-systems-with-otp/"
      })

    bk3_au1 =
      val.(%{
        id: :james_gray,
        name: "James Edward Gray II",
        url: "https://twitter.com/JEG2"
      })

    bk3_au2 =
      val.(%{
        id: :bruce_tate,
        name: "Bruce Tate",
        url: "https://twitter.com/redrapids"
      })

    bk3_pub =
      val.(%{
        id: :pragmatic,
        name: "The Pragmatic Bookshelf",
        url: "https://pragprog.com/"
      })

    # book 4
    bk4 =
      val.(%{
        id: :graph_algorithms,
        date: "2019-03-16",
        format: "Paper",
        isbn: "978-1-492-04767-4",
        title: "Graph Algorithms",
        url: "https://www.oreilly.com/library/view/graph-algorithms/9781492047674/"
      })

    bk4_au1 =
      val.(%{
        id: :amy_hodler,
        name: "Amy E. Hodler",
        url: "https://twitter.com/amyhodler"
      })

    bk4_au2 =
      val.(%{
        id: :mark_needham,
        name: "Mark Needham",
        url: "https://twitter.com/markhneedham"
      })

    bk4_pub =
      val.(%{
        id: :oreilly,
        name: "O'Reilly Media",
        url: "https://www.oreilly.com/"
      })

    # build graph
    g =
      Graph.new(type: :directed)
      #
      |> Graph.add_vertex(bk1, "Book")
      |> Graph.add_vertex(bk1_au1, "Author")
      |> Graph.add_vertex(bk1_au2, "Author")
      |> Graph.add_vertex(bk1_au3, "Author")
      |> Graph.add_vertex(bk1_pub, "Publisher")
      |> Graph.add_edge(bk1_pub, bk1, label: "BOOK")
      |> Graph.add_edge(bk1, bk1_au1, label: "AUTHOR")
      |> Graph.add_edge(bk1, bk1_au2, label: "AUTHOR")
      |> Graph.add_edge(bk1, bk1_au3, label: "AUTHOR")
      |> Graph.add_edge(bk1, bk1_pub, label: "PUBLISHER")

    g =
      if all_books? do
        g
        |> Graph.add_vertex(bk2, "Book")
        |> Graph.add_vertex(bk2_au1, "Author")
        |> Graph.add_vertex(bk2_au2, "Author")
        |> Graph.add_vertex(bk2_pub, "Publisher")
        |> Graph.add_edge(bk2_pub, bk2, label: "BOOK")
        |> Graph.add_edge(bk2, bk2_au1, label: "AUTHOR")
        |> Graph.add_edge(bk2, bk2_au2, label: "AUTHOR")
        |> Graph.add_edge(bk2, bk2_pub, label: "PUBLISHER")
        #
        |> Graph.add_vertex(bk3, "Book")
        |> Graph.add_vertex(bk3_au1, "Author")
        |> Graph.add_vertex(bk3_au2, "Author")
        |> Graph.add_vertex(bk3_pub, "Publisher")
        |> Graph.add_edge(bk3_pub, bk3, label: "BOOK")
        |> Graph.add_edge(bk3, bk3_au1, label: "AUTHOR")
        |> Graph.add_edge(bk3, bk3_au2, label: "AUTHOR")
        |> Graph.add_edge(bk3, bk3_pub, label: "PUBLISHER")
        #
        |> Graph.add_vertex(bk4, "Book")
        |> Graph.add_vertex(bk4_au1, "Author")
        |> Graph.add_vertex(bk4_au2, "Author")
        |> Graph.add_vertex(bk4_pub, "Publisher")
        |> Graph.add_edge(bk4_pub, bk4, label: "BOOK")
        |> Graph.add_edge(bk4, bk4_au1, label: "AUTHOR")
        |> Graph.add_edge(bk4, bk4_au2, label: "AUTHOR")
        |> Graph.add_edge(bk4, bk4_pub, label: "PUBLISHER")
      else
        g
      end

    g
  end
end
