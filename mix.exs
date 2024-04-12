defmodule SFDCQuery.MixProject do
  use Mix.Project

  @version "0.1.1"

  def project do
    [
      version: @version,
      app: :sfdc_query,
      description: "Query Salesforce data easily formatting and viewing the data as you want!",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      name: "sfdc_query",
      files: ~w(lib .credo.exs .formatter.exs mix.exs README*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/linqueta/sfdc_query"}
    ]
  end

  defp docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      formatters: ["html"],
      extras: ["README.md"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false, override: true},
      {:mimic, "~> 1.7", only: [:dev, :test]},
      {:req, "~> 0.4.0"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end
end
