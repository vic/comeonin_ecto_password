defmodule ComeoninEctoPassword.Mixfile do
  use Mix.Project

  def project do
    [app: :comeonin_ecto_password,
     version: "2.0.0",
     elixir: "~> 1.3",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
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
    [files: ~w(lib mix.exs README* LICENSE),
     maintainers: ["Victor Hugo Borja <vborja@apache.org>"],
     licenses: ["BSD"],
     links: %{
       "GitHub" => "https://github.com/vic/comeonin_ecto_password"
     }]
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
    [{:ecto, "~> 2.0"},
     {:comeonin, "~> 2.0"}]
  end
end
