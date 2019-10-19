# Comeonin Ecto Password <a href="https://travis-ci.org/vic/comeonin_ecto_password"><img src="https://travis-ci.org/vic/comeonin_ecto_password.svg"></a>

A [custom Ecto type](https://hexdocs.pm/ecto/Ecto.Type.html#summary) for storing encrypted passwords using [Comeonin](https://github.com/elixircnx/comeonin)

For ecto 1 compatibility use the `ecto-1` branch.

_Version 3.x is compatible with `comeonin` ~> 5.0_, use version 2.x for compatibility with older versions.

## Usage

On your schema, define secure fields with this type:

```elixir
field :password, Comeonin.Ecto.Password
```

Then on your changeset simply cast from plain-text params

```elixir
changeset
|> cast(attrs, [:password])
|> validate_required([:password])
```

After casting the password will already be encrypted
in the changeset, and can be saved to your table's
string column.

To check for validity, do something like:

```elixir
user = Repo.get_by(User, email: "me@example.org")
Comeonin.Ecto.Password.valid?("plain_password", user.password)
```

## Configuration

In your environment file, choose one of `Pbkdf2`, `Bcrypt`, `Argon2`.
The default is 'Pbkdf2`, but you still need to include it in your `mix.exs`!

```elixir
config :comeonin, Ecto.Password, Pbkdf2

# when using pkbdf2
config :comeonin, :pbkdf2_rounds, 120_000
config :comeonin, :pbkdf2_salt_len, 512

# when using bcrypt
config :comeonin, :bcrypt_log_rounds, 14
```

Also, be sure to look at [comeonin](https://github.com/elixircnx/comeonin#installation) [config](http://hexdocs.pm/comeonin/Comeonin.Config.html)

## Installation

[Available in Hex](https://hex.pm/packages/comeonin_ecto_password), the package can be installed as:

Add comeonin_ecto_password to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:comeonin_ecto_password, "~> 3.0.0"}]
end
```
