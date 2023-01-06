#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule GraphCompute.Application do
  use Application

  def start(type, args) do
    do_dynamic_supervisor(type, args)
    do_static_supervisor(type, args)
  end

  defp do_dynamic_supervisor(_type, _args) do
    opts = [
      name: GraphCompute.DynamicSupervisor,
      strategy: :one_for_one
    ]
    DynamicSupervisor.start_link(opts)
  end

  defp do_static_supervisor(_type, _args) do
    children = [
      {GraphCompute.Graph, %{}},
      {GraphCompute.State, %{}}
    ]
    opts = [
      name: GraphCompute.Supervisor,
      strategy: :one_for_one
    ]
    Supervisor.start_link(children, opts)
  end

  def genserver() do
    case DynamicSupervisor.start_child(
        GraphCompute.DynamicSupervisor, GraphCompute.Process
      ) do
      {:ok, pid} ->
        pid
      {:error, reason} ->
        IO.puts "! Error: #{inspect reason}"
    end
  end

end
