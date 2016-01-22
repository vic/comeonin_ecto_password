defmodule ComeoninEctoPasswordTest do
  use ExUnit.Case

  import Comeonin.Ecto.Password

  test "underlying database type is string" do
    assert :string == type
  end

  test "cast string into crypted hash" do
    cast("hello") |> case do
       {:ok, x} when is_binary(x) -> assert valid?("hello", x)
    end
  end

  test "load string" do
    assert {:ok ,"foo"} = load("foo")
    assert :error = load(nil)
  end

  test "dump string" do
    assert {:ok, "foo"} = dump("foo")
    assert :error = dump(nil)
  end

end
