# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn.Buffer do
  @moduledoc """
  Buffer management for WebGPU.

  Provides functions for creating and managing GPU buffers (vertex, index, uniform).
  Similar to Godot's buffer management with staging buffer support.
  """

  alias ExDawn.Native

  @type buffer :: reference()
  @type device :: ExDawn.Device.device()
  @type usage_flag :: :vertex | :index | :uniform | :storage | :copy_src | :copy_dst

  @doc """
  Creates a new WebGPU buffer.

  ## Parameters

  - `device`: The WebGPU device
  - `size`: Size of the buffer in bytes
  - `usage`: List of usage flags (e.g., `[:vertex, :copy_dst]`)

  ## Examples

      iex> {:ok, device} = ExDawn.Device.create()
      iex> {:ok, buffer} = ExDawn.Buffer.create_buffer(device, 1024, [:vertex, :copy_dst])
      iex> is_reference(buffer)
      true

  """
  @spec create_buffer(device(), non_neg_integer(), [usage_flag()]) ::
          {:ok, buffer()} | {:error, term()}
  def create_buffer(device, size, usage \\ [:vertex, :copy_dst]) when is_list(usage) do
    Native.create_buffer(device, size, usage)
  end

  @doc """
  Writes data to a buffer.

  The data will be staged and uploaded to the GPU efficiently.

  ## Parameters

  - `device`: The WebGPU device
  - `buffer`: The target buffer
  - `data`: Binary data to write

  ## Examples

      iex> {:ok, device} = ExDawn.Device.create()
      iex> {:ok, buffer} = ExDawn.Buffer.create_buffer(device, 1024)
      iex> ExDawn.Buffer.write_buffer(device, buffer, <<1, 2, 3, 4>>)
      :ok

  """
  @spec write_buffer(device(), buffer(), binary()) :: :ok | {:error, term()}
  def write_buffer(device, buffer, data) when is_binary(data) do
    Native.write_buffer(device, buffer, data)
  end
end
