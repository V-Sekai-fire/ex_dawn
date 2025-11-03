/* SPDX-License-Identifier: MIT
 * Copyright (c) 2025-present K. S. Ernest (iFire) Lee
 */

#include <erl_nif.h>
#include <string.h>
#include <cstdint>
#include <map>
#include <memory>

// TODO: Include Dawn WebGPU headers when available
// #include "webgpu.h"
// #include "webgpu_cpp.h"

// Forward declarations for Dawn types (will be replaced with actual includes)
struct WGPUInstanceImpl;
struct WGPUAdapterImpl;
struct WGPUDeviceImpl;
struct WGPUBufferImpl;
struct WGPUTextureImpl;

typedef WGPUInstanceImpl* WGPUInstance;
typedef WGPUAdapterImpl* WGPUAdapter;
typedef WGPUDeviceImpl* WGPUDevice;
typedef WGPUBufferImpl* WGPUBuffer;
typedef WGPUTextureImpl* WGPUTexture;

// Resource types for ErlNifResource
typedef struct {
    WGPUInstance instance;
} DawnInstance;

typedef struct {
    WGPUAdapter adapter;
} DawnAdapter;

typedef struct {
    WGPUDevice device;
} DawnDevice;

typedef struct {
    WGPUBuffer buffer;
    uint64_t size;
} DawnBuffer;

typedef struct {
    WGPUTexture texture;
} DawnTexture;

// Global resource owners
static ErlNifResourceType* DAWN_INSTANCE_RESOURCE = NULL;
static ErlNifResourceType* DAWN_ADAPTER_RESOURCE = NULL;
static ErlNifResourceType* DAWN_DEVICE_RESOURCE = NULL;
static ErlNifResourceType* DAWN_BUFFER_RESOURCE = NULL;
static ErlNifResourceType* DAWN_TEXTURE_RESOURCE = NULL;

// Helper: Convert Elixir binary to C string
static bool get_binary_string(ErlNifEnv* env, ERL_NIF_TERM term, std::string& out) {
    ErlNifBinary bin;
    if (!enif_inspect_binary(env, term, &bin)) {
        return false;
    }
    out = std::string((const char*)bin.data, bin.size);
    return true;
}

// Helper: Convert C string to Elixir binary
static ERL_NIF_TERM make_binary_string(ErlNifEnv* env, const char* str, size_t len) {
    ErlNifBinary bin;
    if (!enif_alloc_binary(len, &bin)) {
        return enif_make_atom(env, "error");
    }
    memcpy(bin.data, str, len);
    return enif_make_binary(env, &bin);
}

// Resource destructors
static void dawn_instance_dtor(ErlNifEnv* env, void* obj) {
    DawnInstance* instance = (DawnInstance*)obj;
    // TODO: Release WGPUInstance when Dawn is integrated
    // wgpuInstanceRelease(instance->instance);
}

static void dawn_adapter_dtor(ErlNifEnv* env, void* obj) {
    DawnAdapter* adapter = (DawnAdapter*)obj;
    // TODO: Release WGPUAdapter when Dawn is integrated
    // wgpuAdapterRelease(adapter->adapter);
}

static void dawn_device_dtor(ErlNifEnv* env, void* obj) {
    DawnDevice* device = (DawnDevice*)obj;
    // TODO: Release WGPUDevice when Dawn is integrated
    // wgpuDeviceRelease(device->device);
}

static void dawn_buffer_dtor(ErlNifEnv* env, void* obj) {
    DawnBuffer* buffer = (DawnBuffer*)obj;
    // TODO: Release WGPUBuffer when Dawn is integrated
    // wgpuBufferRelease(buffer->buffer);
}

static void dawn_texture_dtor(ErlNifEnv* env, void* obj) {
    DawnTexture* texture = (DawnTexture*)obj;
    // TODO: Release WGPUTexture when Dawn is integrated
    // wgpuTextureRelease(texture->texture);
}

// NIF: create_instance/0
static ERL_NIF_TERM nif_create_instance(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
    // TODO: Implement with Dawn
    // WGPUInstanceDescriptor desc = {};
    // WGPUInstance instance = wgpuCreateInstance(&desc);
    
    DawnInstance* instance = (DawnInstance*)enif_alloc_resource(DAWN_INSTANCE_RESOURCE, sizeof(DawnInstance));
    if (!instance) {
        return enif_make_atom(env, "error");
    }
    
    // TODO: Set instance->instance = instance when Dawn is integrated
    instance->instance = nullptr;
    
    ERL_NIF_TERM resource_term = enif_make_resource(env, instance);
    enif_release_resource(instance);
    
    return enif_make_tuple2(env, enif_make_atom(env, "ok"), resource_term);
}

// NIF: create_adapter/1
static ERL_NIF_TERM nif_create_adapter(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
    // TODO: Implement with Dawn
    // Extract instance from argv[0]
    DawnInstance* instance = nullptr;
    if (!enif_get_resource(env, argv[0], DAWN_INSTANCE_RESOURCE, (void**)&instance)) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "invalid_instance"));
    }
    
    // TODO: Request adapter from instance
    // WGPURequestAdapterOptions options = {};
    // WGPUAdapter adapter = wgpuInstanceRequestAdapter(instance->instance, &options);
    
    DawnAdapter* adapter = (DawnAdapter*)enif_alloc_resource(DAWN_ADAPTER_RESOURCE, sizeof(DawnAdapter));
    if (!adapter) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "alloc_failed"));
    }
    
    adapter->adapter = nullptr; // TODO: Set when Dawn is integrated
    
    ERL_NIF_TERM resource_term = enif_make_resource(env, adapter);
    enif_release_resource(adapter);
    
    return enif_make_tuple2(env, enif_make_atom(env, "ok"), resource_term);
}

// NIF: create_device/1
static ERL_NIF_TERM nif_create_device(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
    // TODO: Implement with Dawn
    DawnAdapter* adapter = nullptr;
    if (!enif_get_resource(env, argv[0], DAWN_ADAPTER_RESOURCE, (void**)&adapter)) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "invalid_adapter"));
    }
    
    // TODO: Request device from adapter
    // WGPUDeviceDescriptor desc = {};
    // WGPUDevice device = wgpuAdapterRequestDevice(adapter->adapter, &desc);
    
    DawnDevice* device = (DawnDevice*)enif_alloc_resource(DAWN_DEVICE_RESOURCE, sizeof(DawnDevice));
    if (!device) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "alloc_failed"));
    }
    
    device->device = nullptr; // TODO: Set when Dawn is integrated
    
    ERL_NIF_TERM resource_term = enif_make_resource(env, device);
    enif_release_resource(device);
    
    return enif_make_tuple2(env, enif_make_atom(env, "ok"), resource_term);
}

// NIF: create_buffer/3
static ERL_NIF_TERM nif_create_buffer(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
    // TODO: Implement with Dawn
    DawnDevice* device = nullptr;
    if (!enif_get_resource(env, argv[0], DAWN_DEVICE_RESOURCE, (void**)&device)) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "invalid_device"));
    }
    
    uint64_t size;
    if (!enif_get_ulong(env, argv[1], &size)) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "invalid_size"));
    }
    
    // TODO: Extract usage flags from argv[2] (list of atoms)
    // WGPUBufferUsageFlags usage = WGPUBufferUsage_Vertex | WGPUBufferUsage_Index;
    
    // TODO: Create buffer
    // WGPUBufferDescriptor desc = {};
    // desc.size = size;
    // desc.usage = usage;
    // WGPUBuffer buffer = wgpuDeviceCreateBuffer(device->device, &desc);
    
    DawnBuffer* buffer = (DawnBuffer*)enif_alloc_resource(DAWN_BUFFER_RESOURCE, sizeof(DawnBuffer));
    if (!buffer) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "alloc_failed"));
    }
    
    buffer->buffer = nullptr; // TODO: Set when Dawn is integrated
    buffer->size = size;
    
    ERL_NIF_TERM resource_term = enif_make_resource(env, buffer);
    enif_release_resource(buffer);
    
    return enif_make_tuple2(env, enif_make_atom(env, "ok"), resource_term);
}

// NIF: write_buffer/2
static ERL_NIF_TERM nif_write_buffer(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]) {
    // TODO: Implement with Dawn
    DawnDevice* device = nullptr;
    if (!enif_get_resource(env, argv[0], DAWN_DEVICE_RESOURCE, (void**)&device)) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "invalid_device"));
    }
    
    DawnBuffer* buffer = nullptr;
    if (!enif_get_resource(env, argv[1], DAWN_BUFFER_RESOURCE, (void**)&buffer)) {
        return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "invalid_buffer"));
    }
    
    // TODO: Extract binary data from argv[2] and write to buffer
    // ErlNifBinary bin;
    // if (!enif_inspect_binary(env, argv[2], &bin)) {
    //     return enif_make_tuple2(env, enif_make_atom(env, "error"), enif_make_atom(env, "invalid_data"));
    // }
    // wgpuQueueWriteBuffer(queue, buffer->buffer, 0, bin.data, bin.size);
    
    return enif_make_atom(env, "ok");
}

// Function exports
static ErlNifFunc nif_funcs[] = {
    {"create_instance", 0, nif_create_instance},
    {"create_adapter", 1, nif_create_adapter},
    {"create_device", 1, nif_create_device},
    {"create_buffer", 3, nif_create_buffer},
    {"write_buffer", 3, nif_write_buffer}
};

// NIF module initialization
static int load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info) {
    DAWN_INSTANCE_RESOURCE = enif_open_resource_type(env, NULL, "dawn_instance", dawn_instance_dtor, ERL_NIF_RT_CREATE, NULL);
    DAWN_ADAPTER_RESOURCE = enif_open_resource_type(env, NULL, "dawn_adapter", dawn_adapter_dtor, ERL_NIF_RT_CREATE, NULL);
    DAWN_DEVICE_RESOURCE = enif_open_resource_type(env, NULL, "dawn_device", dawn_device_dtor, ERL_NIF_RT_CREATE, NULL);
    DAWN_BUFFER_RESOURCE = enif_open_resource_type(env, NULL, "dawn_buffer", dawn_buffer_dtor, ERL_NIF_RT_CREATE, NULL);
    DAWN_TEXTURE_RESOURCE = enif_open_resource_type(env, NULL, "dawn_texture", dawn_texture_dtor, ERL_NIF_RT_CREATE, NULL);
    
    if (!DAWN_INSTANCE_RESOURCE || !DAWN_ADAPTER_RESOURCE || !DAWN_DEVICE_RESOURCE || 
        !DAWN_BUFFER_RESOURCE || !DAWN_TEXTURE_RESOURCE) {
        return 1;
    }
    
    return 0;
}

ERL_NIF_INIT(Elixir.ExDawn.Native, nif_funcs, load, NULL, NULL, NULL)

