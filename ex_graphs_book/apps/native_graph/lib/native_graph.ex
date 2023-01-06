#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule NativeGraph do

  ## GRAPH STORE

  use GraphCommons.Graph, graph_type: :native, graph_module: __MODULE__
  use GraphCommons.Query, query_type: :native, query_module: __MODULE__

  ## WRITE IMAGE

  defdelegate write_image(arg), to: NativeGraph.Format, as: :to_png

  defdelegate random_graph(arg), to: NativeGraph.Builder, as: :random_graph

  defdelegate to_dot(arg), to: NativeGraph.Serializers.DOT, as: :serialize
  defdelegate to_dot!(arg), to: NativeGraph.Serializers.DOT, as: :serialize!

end
