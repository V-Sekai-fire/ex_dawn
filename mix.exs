# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_dawn,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      compilers: [:elixir_make | Mix.compilers()],
      make_targets: ["all"],
      make_clean: ["clean"],
      deps: deps(),
      docs: [
        main: "ExDawn",
        source_url: "https://github.com/V-Sekai-fire/ex_dawn"
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:elixir_make, "~> 0.7", runtime: false},
      {:aria_math, git: "https://github.com/V-Sekai-fire/aria-math.git"},
      {:aria_gltf, git: "https://github.com/V-Sekai-fire/aria-gltf.git"},
      {:ex_doc, "~> 0.30", only: :dev, runtime: false}
    ]
  end
end

