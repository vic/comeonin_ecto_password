defmodule ComeoninEctoPassword.Mixfile do
  use Mix.Project

  def project do
    [
      app: :comeonin_ecto_password,
      version: "2.1.0",
      elixir: "~> 1.4",
      description: description(),
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  def description do
    """
    Ecto custom type for storing encrypted password using Comeonin
    """
  end

  def package do
    [
      files: ~w(lib mix.exs README* LICENSE),
      maintainers: ["Victor Hugo Borja <vborja@apache.org>"],
      licenses: ["BSD"],
      links: %{
        "GitHub" => "https://github.com/vic/comeonin_ecto_password"
      }
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ecto, "~> 2.2"},
      {:comeonin, "~> 4.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:pbkdf2_elixir, "~> 0.12", optional: true},
      {:bcrypt_elixir, "~> 1.1", optional: true},
      {:argon2_elixir, "~> 1.3", optional: true}
    ]
  end
end
