# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn.Texture do
  @moduledoc """
  Texture management for WebGPU.

  Provides functions for creating textures from image data and integrating
  with aria_gltf Image structures.
  """

  alias ExDawn.Native

  @type texture :: reference()
  @type device :: ExDawn.Device.device()

  @doc """
  Creates a texture from image data.

  TODO: [2025-01-15] fire - Implement texture creation from image data with Native NIF

  ## Parameters

  - `device`: The WebGPU device
  - `width`: Texture width in pixels
  - `height`: Texture height in pixels
  - `format`: Texture format (e.g., `:rgba8_unorm`)
  - `data`: Image pixel data

  ## Examples

      iex> {:ok, device} = ExDawn.Device.create()
      iex> data = :binary.list_to_bin(List.duplicate([255, 0, 0, 255], 256))
      iex> {:ok, texture} = ExDawn.Texture.create_texture(device, 16, 16, :rgba8_unorm, data)
      iex> is_reference(texture)
      true

  """
  @spec create_texture(device(), non_neg_integer(), non_neg_integer(), atom(), binary()) ::
          {:ok, texture()} | {:error, term()}
  def create_texture(device, width, height, format, data)
      when is_integer(width) and is_integer(height) and is_binary(data) do
    {:error, :not_implemented}
  end

  @doc """
  Creates a texture view from a texture.

  TODO: [2025-01-15] fire - Implement texture view creation with Native NIF

  ## Examples

      iex> {:ok, texture} = ExDawn.Texture.create_texture(device, 16, 16, :rgba8_unorm, data)
      iex> {:ok, view} = ExDawn.Texture.create_texture_view(texture)
      iex> is_reference(view)
      true

  """
  @spec create_texture_view(texture()) :: {:ok, reference()} | {:error, term()}
  def create_texture_view(texture) do
    {:error, :not_implemented}
  end

  @doc """
  Creates a texture from an aria_gltf Image structure.

  TODO: [2025-01-15] fire - Load image data from GLTF Image and create texture

  ## Examples

      iex> image = %AriaGltf.Image{uri: "texture.png", mime_type: "image/png"}
      iex> {:ok, texture} = ExDawn.Texture.from_gltf_image(device, image)
      iex> is_reference(texture)
      true

  """
  @spec from_gltf_image(device(), AriaGltf.Image.t()) :: {:ok, texture()} | {:error, term()}
  def from_gltf_image(device, %AriaGltf.Image{} = image) do
    {:error, :not_implemented}
  end
end
