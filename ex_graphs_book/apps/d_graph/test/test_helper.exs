#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
{:ok, _} = Application.ensure_all_started(:grpc)
ExUnit.start()

defmodule Dlex.User do
  use Dlex.Node

  schema "user" do
    field :name, :string, index: ["term"]
    field :age, :integer
    field :friends, :uid
    field :cache, :any, virtual: true
  end
end

defmodule Dlex.TestRepo do
  use Dlex.Repo, otp_app: :dlex, modules: [Dlex.User]
end

defmodule Dlex.TestHelper do
  @dlex_adapter :"#{System.get_env("DLEX_ADAPTER", "grpc")}"
  @offset String.to_integer(System.get_env("DLEX_PORT_OFFSET", "0"))

  def opts() do
    case @dlex_adapter do
      :http -> [transport: :http, port: 8080 + @offset]
      :grpc -> [transport: :grpc, port: 9080 + @offset]
    end
  end

  def drop_all(pid) do
    Dlex.alter(pid, %{drop_all: true})
  end
end
