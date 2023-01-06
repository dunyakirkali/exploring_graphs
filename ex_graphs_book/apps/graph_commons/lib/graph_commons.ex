#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCommons do

  ## ATTRIBUTES

  @root_dir Application.fetch_env!(:graph_commons, :root_dir)

  ## TYPES

  @type base_type :: :dgraph | :native | :property | :rdf | :tinker
  @type graph_type :: base_type()
  @type query_type :: base_type()

  @type file_test :: :dir? | :regular? | :exists?

  ## FUNCTIONS

  def apps_dir(), do: @root_dir <> "/apps"
  def priv_dir(), do: @root_dir <> "/apps/graph_commons/priv"

  def scripts_dir(), do: priv_dir() <> "/scripts"
  def storage_dir(), do: priv_dir() <> "/storage"

  def hello do
    IO.puts("This is ExGraphsBook - an Elixir umbrella app:\n")
    list =
      Enum.sort (for app <- File.ls!(GraphCommons.apps_dir), do:
          String.to_existing_atom(app))
    IO.puts(inspect(list, limit: :infinity, pretty: true))
  end

end
