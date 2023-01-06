#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule DGraph.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Dlex, Application.get_env(:dlex, Dlex, [])},
    ]

    opts = [strategy: :one_for_one, name: DGraph.Service]
    {:ok, pid} = Supervisor.start_link(children, opts)
    [{_, child_pid, _, _}] = Supervisor.which_children(pid)
    Application.put_env(:dlex, PID, child_pid)
    {:ok, pid}
  end

end
