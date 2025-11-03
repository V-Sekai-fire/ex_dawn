# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn.Device do
  @moduledoc """
  WebGPU Device wrapper for managing GPU resources.

  Provides functions for creating WebGPU instances, adapters, and devices.
  Similar to Godot's RenderingDevice abstraction.
  """

  alias ExDawn.Native

  @type instance :: reference()
  @type adapter :: reference()
  @type device :: reference()

  @doc """
  Creates a new WebGPU instance.

  ## Examples

      iex> {:ok, instance} = ExDawn.Device.create_instance()
      iex> is_reference(instance)
      true

  """
  @spec create_instance() :: {:ok, instance()} | {:error, term()}
  def create_instance do
    Native.create_instance()
  end

  @doc """
  Requests a WebGPU adapter from an instance.

  ## Examples

      iex> {:ok, instance} = ExDawn.Device.create_instance()
      iex> {:ok, adapter} = ExDawn.Device.create_adapter(instance)
      iex> is_reference(adapter)
      true

  """
  @spec create_adapter(instance()) :: {:ok, adapter()} | {:error, term()}
  def create_adapter(instance) do
    Native.create_adapter(instance)
  end

  @doc """
  Creates a WebGPU device from an adapter.

  ## Examples

      iex> {:ok, instance} = ExDawn.Device.create_instance()
      iex> {:ok, adapter} = ExDawn.Device.create_adapter(instance)
      iex> {:ok, device} = ExDawn.Device.create_device(adapter)
      iex> is_reference(device)
      true

  """
  @spec create_device(adapter()) :: {:ok, device()} | {:error, term()}
  def create_device(adapter) do
    Native.create_device(adapter)
  end
end

