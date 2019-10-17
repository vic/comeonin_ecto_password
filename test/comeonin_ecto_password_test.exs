defmodule ComeoninEctoPasswordTest do
  use ExUnit.Case

  import Comeonin.Ecto.Password

  test "underlying database type is string" do
    assert :string == type()
  end

  # nil -> Use default
  for crypt <- [Bcrypt, Argon2, Pbkdf2, nil] do
    if crypt do
      @crypt crypt
      setup do
        Application.put_env(:comeonin, Ecto.Password, @crypt)
      end
    else
      @crypt "default"
    end

    test "#{@crypt}: cast string into crypted hash" do
      cast("hello")
      |> case do
        {:ok, x} when is_binary(x) -> assert valid?("hello", x)
      end
    end

    test "#{@crypt}: load string" do
      assert {:ok, "foo"} = load("foo")
      assert :error = load(nil)
    end

    test "#{@crypt}: dump string" do
      assert {:ok, "foo"} = dump("foo")
      assert :error = dump(nil)
    end

    test "#{@crypt}: Empty string does not get encrypted" do
      assert {:ok, ""} = cast("")
    end

    test "#{@crypt}: embed_as" do
      assert :dump = embed_as(:string)
    end

    test "#{@crypt}: equal?" do
      assert equal?("string", "string")
    end
  end
end
