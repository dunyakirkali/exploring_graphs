#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule NativeGraph.Format do

  @graph_images_dir GraphCommons.storage_dir() <> "/native/graphs/images/"
  @dot_exe "/usr/local/bin/dot"

  def to_png(%GraphCommons.Graph{} = graph) do
    dot_file = graph.path
    png_file = @graph_images_dir <> Path.basename(dot_file, ".dot") <> ".png"

    with {_, 0} <-
           System.cmd(@dot_exe, ["-T", "png", dot_file, "-o", png_file]) do
        {:ok, Path.basename(png_file)}
      else
        _ -> {:error, "! Error"}
    end
  end

end
