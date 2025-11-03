# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn.Examples.ModelViewer do
  @moduledoc """
  Model viewer example for GLTF, FBX, and OBJ formats.

  Demonstrates how to load and render different 3D model formats.
  """

  alias ExDawn.{Device, GltfRenderer, FbxRenderer, ObjRenderer, Renderer}
  alias AriaMath.Vector3

  @doc """
  View a GLTF model.
  """
  def view_gltf(device, path) do
    case AriaGltf.Import.from_file(path) do
      {:ok, document} ->
        case GltfRenderer.load(device, document) do
          {:ok, model} ->
            # Set up camera
            eye = Vector3.new(0.0, 0.0, 5.0)
            target = Vector3.new(0.0, 0.0, 0.0)
            up = Vector3.new(0.0, 1.0, 0.0)
            view = Renderer.look_at(eye, target, up)
            proj = Renderer.perspective(:math.pi() / 4, 16.0 / 9.0, 0.1, 100.0)

            # Render
            GltfRenderer.render(device, model, view, proj)
            IO.puts("GLTF model rendered: #{path}")

          {:error, reason} ->
            IO.puts("Error loading GLTF model: #{inspect(reason)}")
        end

      {:error, reason} ->
        IO.puts("Error parsing GLTF file: #{inspect(reason)}")
    end
  end

  @doc """
  View an FBX model.
  """
  def view_fbx(device, path) do
    case AriaFbx.Import.from_file(path) do
      {:ok, document} ->
        case FbxRenderer.load(device, document) do
          {:ok, model} ->
            # Set up camera
            eye = Vector3.new(0.0, 0.0, 5.0)
            target = Vector3.new(0.0, 0.0, 0.0)
            up = Vector3.new(0.0, 1.0, 0.0)
            view = Renderer.look_at(eye, target, up)
            proj = Renderer.perspective(:math.pi() / 4, 16.0 / 9.0, 0.1, 100.0)

            # Render
            FbxRenderer.render(device, model, view, proj)
            IO.puts("FBX model rendered: #{path}")

          {:error, reason} ->
            IO.puts("Error loading FBX model: #{inspect(reason)}")
        end

      {:error, reason} ->
        IO.puts("Error parsing FBX file: #{inspect(reason)}")
    end
  end

  @doc """
  View an OBJ model.
  """
  def view_obj(device, path) do
    case ObjRenderer.load(device, path) do
      {:ok, model} ->
        # Set up camera
        eye = Vector3.new(0.0, 0.0, 5.0)
        target = Vector3.new(0.0, 0.0, 0.0)
        up = Vector3.new(0.0, 1.0, 0.0)
        view = Renderer.look_at(eye, target, up)
        proj = Renderer.perspective(:math.pi() / 4, 16.0 / 9.0, 0.1, 100.0)

        # Render
        ObjRenderer.render(device, model, view, proj)
        IO.puts("OBJ model rendered: #{path}")

      {:error, reason} ->
        IO.puts("Error loading OBJ model: #{inspect(reason)}")
    end
  end

  @doc """
  Main entry point for model viewer.
  """
  def main(args) do
    # Create device
    {:ok, device} = Device.create()

    case args do
      [path | _] ->
        case Path.extname(path) do
          ".gltf" -> view_gltf(device, path)
          ".glb" -> view_gltf(device, path)
          ".fbx" -> view_fbx(device, path)
          ".obj" -> view_obj(device, path)
          _ -> IO.puts("Unsupported file format: #{Path.extname(path)}")
        end

      [] ->
        IO.puts("Usage: model_viewer <path_to_model>")
        IO.puts("Supported formats: .gltf, .glb, .fbx, .obj")
    end
  end
end

