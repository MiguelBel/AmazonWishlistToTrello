defmodule AmazonWishlistToTrello.Mixfile do
  use Mix.Project

  def project do
    [
      app: :AmazonWishlistToTrello,
      version: "1.0.0",
      deps: deps,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod
    ]
  end

  def application do
    [applications: [:logger, :httpoison, :floki]]
  end

  defp deps do
    [
      {:floki, "~> 0.7"},
      {:httpoison, "~> 0.8.0"},
      {:exredis, "~> 0.2.2"}
    ]
  end
end
