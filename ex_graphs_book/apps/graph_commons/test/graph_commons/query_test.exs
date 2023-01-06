#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCommons.QueryTest do
  use ExUnit.Case
  #  doctest GraphCommons.Query

  alias GraphCommons.Query

  def test_query() do
    data = "data"
    file = "test"
    type = :rdf
    %Query{data: data, file: file, type: type}
  end

  describe "Query struct" do
    test "one" do
      assert test_query()
    end
  end

  describe "new/3" do
    test "new/3" do
      data = "data"
      file = "test"
      type = :rdf
      query = %{Query.new(data, file, type) | path: nil, uri: nil}
      assert ^query = test_query()
    end
  end
end
