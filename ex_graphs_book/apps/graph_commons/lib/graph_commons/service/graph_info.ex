#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCommons.Service.GraphInfo do

  defstruct ~w[type file num_nodes num_edges labels]a

  @type t :: %__MODULE__{
          type: :dgraph | :native | :property | :rdf | :tinker,
          file: String.t(),
          num_nodes: integer,
          num_edges: integer,
          labels: list
        }
end
