#---
# Excerpted from "Exploring Graphs with Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/thgraphs for more book information.
#---
defmodule Dlex.RepoTest do
  use ExUnit.Case

  alias Dlex.{TestHelper, TestRepo, User}

  setup_all do
    {:ok, pid} = TestRepo.start_link(TestHelper.opts())
    %{pid: pid}
  end

  describe "schema operations" do
    setup do
      TestRepo.register(User)
      TestRepo.alter_schema()
      :ok
    end

    test "basic crud operations" do
      user = %User{name: "Alice", age: 25}
      assert {:ok, %User{uid: uid}} = TestRepo.set(user)
      assert uid != nil
      assert {:ok, %User{uid: ^uid, name: "Alice", age: 25}} = TestRepo.get(uid)
      assert %User{uid: ^uid, name: "Alice", age: 25} = TestRepo.get!(uid)

      assert {:ok, %{"uid_get" => [%User{uid: ^uid, name: "Alice", age: 25}]}} =
               TestRepo.all("{uid_get(func: uid(#{uid})) {uid dgraph.type expand(_all_)}}")

      assert {:ok, %{"uid_get" => [%{"uid" => _, "user.age" => 25, "user.name" => "Alice"}]}} =
               TestRepo.all("{uid_get(func: uid(#{uid})) {uid expand(_all_)}}")
    end
  end
end
