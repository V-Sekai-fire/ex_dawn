# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn.ObjRenderer do
  @moduledoc """
  OBJ model rendering using WebGPU.

  Parses OBJ files and renders them with material/MTL support.
  """

  alias ExDawn.{Device, Buffer, Texture, Pipeline, Renderer}
  alias AriaMath.{Vector3, Matrix4}

  @type device :: Device.device()

  @doc """
  Loads an OBJ model for rendering.

  TODO: [2025-01-15] fire - Parse OBJ file (or reuse aria_gltf processing), parse MTL file if present, convert OBJ geometry to WebGPU buffers, and load textures from MTL materials

  ## Parameters

  - `device`: The WebGPU device
  - `path`: Path to OBJ file

  ## Examples

      iex> {:ok, device} = ExDawn.Device.create()
      iex> {:ok, model} = ExDawn.ObjRenderer.load(device, "model.obj")
      iex> is_map(model)
      true

  """
  @spec load(device(), String.t()) :: {:ok, map()} | {:error, term()}
  def load(device, path) when is_binary(path) do
    {:ok, %{meshes: [], textures: [], materials: []}}
  end

  @doc """
  Renders a loaded OBJ model.

  TODO: [2025-01-15] fire - Begin render pass, draw OBJ meshes with materials, and end render pass

  ## Parameters

  - `device`: The WebGPU device
  - `model`: Model data from load/2
  - `view_matrix`: View transformation matrix
  - `proj_matrix`: Projection transformation matrix

  ## Examples

      iex> {:ok, model} = ExDawn.ObjRenderer.load(device, "model.obj")
      iex> view = ExDawn.Renderer.look_at(eye, target, up)
      iex> proj = ExDawn.Renderer.perspective(fov, aspect, near, far)
      iex> ExDawn.ObjRenderer.render(device, model, view, proj)
      :ok

  """
  @spec render(device(), map(), Matrix4.t(), Matrix4.t()) :: :ok | {:error, term()}
  def render(device, model, view_matrix, proj_matrix) do
    :ok
  end

  @doc """
  Converts OBJ geometry to WebGPU vertex and index buffers.

  TODO: [2025-01-15] fire - Interleave vertex data (position, normal, texcoord), create vertex buffer, and create index buffer

  ## Parameters

  - `device`: The WebGPU device
  - `vertices`: List of vertex positions
  - `normals`: List of vertex normals (optional)
  - `texcoords`: List of texture coordinates (optional)
  - `indices`: List of face indices

  ## Examples

      iex> vertices = [[0, 0, 0], [1, 0, 0], [0, 1, 0]]
      iex> indices = [0, 1, 2]
      iex> {:ok, buffers} = ExDawn.ObjRenderer.geometry_to_buffers(device, vertices, nil, nil, indices)
      iex> %{vertex_buffer: vb, index_buffer: ib} = buffers
      iex> is_reference(vb)
      true

  """
  @spec geometry_to_buffers(
          device(),
          [[float()]],
          [[float()]] | nil,
          [[float()]] | nil,
          [non_neg_integer()]
        ) :: {:ok, map()} | {:error, term()}
  def geometry_to_buffers(device, vertices, normals, texcoords, indices) do
    {:ok, %{vertex_buffer: nil, index_buffer: nil}}
  end
end
