# ExDawn

WebGPU library for Elixir using Google's Dawn implementation.

ExDawn provides high-level WebGPU bindings for rendering GLTF, FBX, and OBJ models, with potential for game development and Three.js WebGPU porting.

## Features

- **WebGPU Bindings**: Low-level C++ NIF bindings to Dawn WebGPU API
- **Model Rendering**: Support for GLTF, FBX, and OBJ model formats
- **Math Integration**: Reuses `aria_math` for Vector3, Matrix4, Quaternion operations
- **Elixir Idiomatic**: High-level Elixir API over low-level NIFs
- **Resource Management**: Proper cleanup of WebGPU resources (RID-based)

## Installation

Add `ex_dawn` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_dawn, path: "../ex_dawn"}
  ]
end
```

## Dependencies

- **Dawn**: WebGPU implementation (C++ library) - needs to be built and installed separately
- **aria_math**: Math operations (automatically fetched from GitHub)
- **aria_gltf**: GLTF/FBX loading (automatically fetched from GitHub)

## Building

```bash
mix deps.get
mix compile
```

Note: Dawn needs to be built separately and linked in the Makefile before compilation will succeed.

## Usage

### Basic Device Creation

```elixir
alias ExDawn.Device

{:ok, instance} = Device.create_instance()
{:ok, adapter} = Device.create_adapter(instance)
{:ok, device} = Device.create_device(adapter)
```

### Creating Buffers

```elixir
alias ExDawn.Buffer

{:ok, buffer} = Buffer.create_buffer(device, 1024, [:vertex, :copy_dst])
:ok = Buffer.write_buffer(device, buffer, <<1, 2, 3, 4>>)
```

### Rendering GLTF Models

```elixir
alias ExDawn.{Device, GltfRenderer, Renderer}
alias AriaGltf.Import

# Load GLTF model
{:ok, document} = Import.from_file("model.gltf")
{:ok, device} = Device.create_instance() |> Device.create_adapter() |> Device.create_device()
{:ok, model} = GltfRenderer.load(device, document)

# Set up camera
eye = AriaMath.Vector3.new(0.0, 0.0, 5.0)
target = AriaMath.Vector3.new(0.0, 0.0, 0.0)
up = AriaMath.Vector3.new(0.0, 1.0, 0.0)
view = Renderer.look_at(eye, target, up)
proj = Renderer.perspective(:math.pi() / 4, 16.0 / 9.0, 0.1, 100.0)

# Render
GltfRenderer.render(device, model, view, proj)
```

### Rendering FBX Models

```elixir
alias ExDawn.FbxRenderer
alias AriaFbx.Import

{:ok, document} = Import.from_file("model.fbx")
{:ok, model} = FbxRenderer.load(device, document)
FbxRenderer.render(device, model, view, proj)
```

### Rendering OBJ Models

```elixir
alias ExDawn.ObjRenderer

{:ok, model} = ObjRenderer.load(device, "model.obj")
ObjRenderer.render(device, model, view, proj)
```

## Architecture

ExDawn follows a layered architecture similar to Godot's rendering system:

- **NIF Layer** (`c_src/dawn_nif.cpp`): Low-level C++ bindings to Dawn WebGPU API
- **Device Layer** (`lib/ex_dawn/device.ex`, `buffer.ex`, etc.): Resource management and WebGPU operations
- **Renderer Layer** (`lib/ex_dawn/renderer.ex`): High-level rendering interface
- **Model Renderers** (`gltf_renderer.ex`, `fbx_renderer.ex`, `obj_renderer.ex`): Format-specific rendering

## Status

⚠️ **Work in Progress**: The library is currently a skeleton implementation. Dawn integration and full rendering pipeline need to be implemented.

## License

MIT

