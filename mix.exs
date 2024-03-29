defmodule Mix.Tasks.Compile.Annoy do
  def run(_) do
    {result, _error_code} = System.cmd("make", ["priv/annoy.so"], stderr_to_stdout: true)
    IO.binwrite(result)
    :ok
  end
end

defmodule AnnoyEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :annoy_ex,
      version: "1.0.0",
      elixir: "~> 1.12",
      compilers: [:annoy, :elixir, :app],
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),

      # Docs
      name: "AnnoyEx",
      source_url: "https://github.com/dallaselynn/annoy_ex",
      homepage_url: "https://hexdocs.pm/annoy_ex",
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:random, "~> 0.2.4", only: :test},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "A NIF binding to Spotify's Annoy C++ library for approximate nearest neighbors."
  end

  defp package() do
    [
      maintainers: ["Dallas Lynn"],
      files: ~w(lib priv .formatter.exs mix.exs README* LICENSE* src Makefile test),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/dallaselynn/annoy_ex"}
    ]
  end
end
