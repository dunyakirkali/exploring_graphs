#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCommons.GraphTest do
  use ExUnit.Case
  doctest GraphCommons.Graph

  alias GraphCommons.Graph

  def test_graph() do
    data = "data"
    file = "test"
    type = :rdf
    %Graph{data: data, file: file, type: type}
  end

  describe "Graph struct" do
    test "one" do
      assert test_graph()
    end
  end

  describe "new/3" do
    test "new/3" do
      data = "data"
      file = "test"
      type = :rdf
      graph = %{Graph.new(data, file, type) | path: nil, uri: nil}
      assert ^graph = test_graph()
    end
  end
end
