#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule NativeGraph.Builder do
  require Integer

  ## FUNCTIONS

  def random_graph(limit) do
    for(n <- 1..limit, m <- (n + 1)..limit, do: do_evaluate(n, m))
    |> Enum.reject(&is_nil/1)
    |> Enum.reduce(
      Graph.new(),
      fn [rs, re], g ->
        Graph.add_edge(g, rs, re)
      end
    )
  end

  defp do_evaluate(n, m) do
    case Integer.is_even(Kernel.trunc(System.os_time() / 1000)) do
      true -> [n, m]
      false -> nil
    end
  end

end
