defmodule Comeonin.Ecto.Password do
  @behaviour Ecto.Type

  @moduledoc """
  A custom Ecto type for storing encrypted passwords.

  ## Usage

  On your schema, define secure fields with this type:

    field :password, Comeonin.Ecto.Password

  Then on your changeset just cast from plain-text params

    cast(changeset, params, ~w(password), ~w())

  After casting the password will already be encrypted,
  and can be saved to your database string column.

  To check for validity, do something like:

     user = Repo.get_by User, email: "me@example.org"
     Comeonin.Ecto.Type.valid?("plain_password", user.password)


  See [Homepage](http://github.com/vic/comeonin_ecto_password)
  """

  def type, do: :string

  def cast(""), do: {:ok, ""}
  def cast(value) when is_binary(value), do: {:ok, hash_password(value)}
  def cast(_), do: :error

  def load(x) when is_binary(x), do: {:ok, x}
  def load(_), do: :error

  def dump(x) when is_binary(x), do: {:ok, x}
  def dump(_), do: :error

  defp crypt, do: Application.get_env(:comeonin, Ecto.Password, Comeonin.Pbkdf2)

  defp hash_password(plain_password) do
    crypt().hashpwsalt(plain_password)
  end

  def valid?(plain_password, hashed_password) do
    crypt().checkpw(plain_password, hashed_password)
  end
end
