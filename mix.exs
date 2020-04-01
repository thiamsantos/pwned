defmodule Pwned.MixProject do
  use Mix.Project

  @version "1.0.3"

  def project do
    [
      app: :pwned,
      version: @version,
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      name: "Pwned",
      source_url: "https://github.com/thiamsantos/pwned"
    ]
  end

  def application do
    [
      applications: [:httpoison],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false}
    ]
  end

  defp description() do
    """
    Check if your password has been pwned.
    """
  end

  defp package() do
    [
      maintainers: ["Thiago Santos"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/thiamsantos/pwned"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      name: "Pwned",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/pwned",
      source_url: "https://github.com/thiamsantos/pwned",
      extras: [
        "README.md",
        "CONTRIBUTING.md"
      ]
    ]
  end
end
