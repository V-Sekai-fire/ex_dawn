# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule ExDawn.Examples.SimpleTriangle do
  @moduledoc """
  Basic triangle rendering example.

  Demonstrates how to set up a WebGPU device, create buffers,
  and render a simple triangle.
  """

  alias ExDawn.{Device, Buffer, Pipeline, Renderer}

  def run do
    # Create device
    {:ok, device} = Device.create()

    # Define triangle vertices (positions + colors)
    vertices = [
      # Position (x, y, z), Color (r, g, b, a)
      {0.0, 0.5, 0.0, 1.0, 0.0, 0.0, 1.0},   # Top vertex (red)
      {-0.5, -0.5, 0.0, 0.0, 1.0, 0.0, 1.0}, # Bottom left (green)
      {0.5, -0.5, 0.0, 0.0, 0.0, 1.0, 1.0}   # Bottom right (blue)
    ]

    # Create vertex buffer
    vertex_data = vertices |> Enum.flat_map(&Tuple.to_list/1) |> :binary.list_to_bin()
    {:ok, vertex_buffer} = Buffer.create_buffer(device, byte_size(vertex_data), [:vertex, :copy_dst])
    :ok = Buffer.write_buffer(device, vertex_buffer, vertex_data)

    # Create render pipeline
    vertex_shader = """
    @vertex
    fn vs(@location(0) position: vec3<f32>, @location(1) color: vec4<f32>) -> @builtin(position) vec4<f32> {
      return vec4<f32>(position, 1.0);
    }
    """

    fragment_shader = """
    @fragment
    fn fs(@location(1) color: vec4<f32>) -> @location(0) vec4<f32> {
      return color;
    }
    """

    {:ok, pipeline} = Pipeline.create_render_pipeline(device,
      vertex_shader: vertex_shader,
      fragment_shader: fragment_shader
    )

    # Begin render pass
    {:ok, pass} = Renderer.begin_render_pass(device, viewport: {0, 0, 800, 600})

    # Draw triangle
    :ok = Renderer.draw(pass, pipeline, vertex_buffer, 3)

    # End render pass
    :ok = Renderer.end_render_pass(pass)

    IO.puts("Triangle rendered successfully!")
  end
end

