# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn do
  @moduledoc """
  ExDawn - WebGPU library for Elixir using Dawn

  Provides high-level WebGPU bindings for rendering GLTF, FBX, and OBJ models.
  """

  @on_load :load_nif

  def load_nif do
    nif_path = :filename.join([:code.priv_dir(:ex_dawn), "dawn_nif"])
    :erlang.load_nif(nif_path, 0)
  end

  defmodule Native do
    @moduledoc false
    # Native NIF functions (implemented in C++)

    def create_instance, do: :erlang.nif_error(:nif_not_loaded)
    def create_adapter(_instance), do: :erlang.nif_error(:nif_not_loaded)
    def create_device(_adapter), do: :erlang.nif_error(:nif_not_loaded)
    def create_buffer(_device, _size, _usage), do: :erlang.nif_error(:nif_not_loaded)
    def write_buffer(_device, _buffer, _data), do: :erlang.nif_error(:nif_not_loaded)
  end
end

