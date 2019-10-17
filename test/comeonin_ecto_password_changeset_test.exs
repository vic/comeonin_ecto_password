defmodule ComeoninEctoPasswordChangesetTest do
  use ExUnit.Case

  alias Comeonin.Ecto.Password

  defmodule TestData do
    use Ecto.Schema
    import Ecto.Changeset

    schema "test" do
      field(:encrypted_password, Password)

      embeds_one :data, Data do
        field(:encrypted_password, Password)
      end
    end

    def changeset(scheme, attrs) do
      scheme
      |> cast(attrs, [:encrypted_password])
      |> cast_embed(:data, with: &data_changeset/2)
    end

    def data_changeset(scheme, attrs) do
      scheme
      |> cast(attrs, [:encrypted_password])
    end
  end

  test "casting an embedded password" do
    changeset =
      TestData.changeset(%TestData{}, %{
        encrypted_password: "password",
        data: %{encrypted_password: "change_me"}
      })

    assert changeset.changes.encrypted_password != "password"
    assert Password.valid?("password", changeset.changes.encrypted_password)
    data = changeset.changes.data
    assert data.changes.encrypted_password != "change_me"
    assert Password.valid?("change_me", data.changes.encrypted_password)
  end
end
