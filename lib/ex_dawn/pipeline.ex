# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn.Pipeline do
  @moduledoc """
  Render and compute pipeline management for WebGPU.

  Provides functions for creating render pipelines with WGSL shaders.
  Similar to Godot's pipeline system with caching support.
  """

  alias ExDawn.Native

  @type pipeline :: reference()
  @type device :: ExDawn.Device.device()

  @doc """
  Creates a render pipeline.

  TODO: [2025-01-15] fire - Implement render pipeline creation with WGSL shader compilation using Native NIF

  ## Parameters

  - `device`: The WebGPU device
  - `opts`: Pipeline configuration options
    - `:vertex_shader` - WGSL vertex shader source (required)
    - `:fragment_shader` - WGSL fragment shader source (required)
    - `:vertex_layout` - Vertex buffer layout
    - `:color_formats` - List of color attachment formats

  ## Examples

      iex> shader = "@vertex fn vs() -> @builtin(position) vec4<f32> { return vec4<f32>(); }"
      iex> {:ok, device} = ExDawn.Device.create()
      iex> {:ok, pipeline} = ExDawn.Pipeline.create_render_pipeline(device, vertex_shader: shader, fragment_shader: shader)
      iex> is_reference(pipeline)
      true

  """
  @spec create_render_pipeline(device(), keyword()) :: {:ok, pipeline()} | {:error, term()}
  def create_render_pipeline(device, opts) when is_list(opts) do
    {:error, :not_implemented}
  end

  @doc """
  Creates a compute pipeline.

  TODO: [2025-01-15] fire - Implement compute pipeline creation with WGSL compute shader compilation using Native NIF

  ## Parameters

  - `device`: The WebGPU device
  - `compute_shader`: WGSL compute shader source

  ## Examples

      iex> shader = "@compute @workgroup_size(64) fn main() {}"
      iex> {:ok, pipeline} = ExDawn.Pipeline.create_compute_pipeline(device, shader)
      iex> is_reference(pipeline)
      true

  """
  @spec create_compute_pipeline(device(), String.t()) :: {:ok, pipeline()} | {:error, term()}
  def create_compute_pipeline(device, compute_shader) when is_binary(compute_shader) do
    {:error, :not_implemented}
  end
end
