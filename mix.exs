defmodule FastXmlToMap.MixProject do
  use Mix.Project

  def project do
    [
      app: :fast_xml_to_map,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: "Creates an Elixir Map data structure from an XML string",
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package() do
    [
      files: ["lib", "config", "test", "mix.exs", "README.md", "LICENSE", ".formatter.exs", "mix.lock", ".gitignore"],
      # files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
      # license* CHANGELOG* changelog* src),
      maintainers: ["Naupio Z.Y. Huang", "Xin Zou"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/edragonconnect/fast_xml_to_map.git"}
    ]
  end


  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:fast_xml, "~> 1.1"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
