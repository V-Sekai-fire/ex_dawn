# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

.PHONY: all clean

# Get Elixir include and lib paths
ERL_EI_INCLUDE_DIR ?= $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/usr/include"])])' -s init stop -noshell)
ERL_EI_LIBDIR ?= $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/usr/lib"])])' -s init stop -noshell)

# Build directory
BUILD_DIR = c_build

# Source files
C_SRC = c_src/dawn_nif.cpp
C_OBJECTS = $(BUILD_DIR)/dawn_nif.o

# Compiler flags
CXXFLAGS = -fPIC -std=c++17 -Wall -Wextra
CXXFLAGS += -I$(ERL_EI_INCLUDE_DIR)
# TODO: [2025-01-15] fire - Add Dawn include paths once Dawn is set up
# CXXFLAGS += -I/path/to/dawn/include

# Linker flags (use -bundle for macOS, -shared for Linux)
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    LDFLAGS = -bundle -undefined dynamic_lookup
    # TODO: [2025-01-15] fire - Link against Dawn libraries when available
    # LDFLAGS += -L/path/to/dawn/lib -ldawn_native
else
    LDFLAGS = -shared
    # TODO: [2025-01-15] fire - Link against Dawn libraries when available
    # LDFLAGS += -L/path/to/dawn/lib -ldawn_native
endif

# Output library
PRIV_DIR = priv
NIF_SO = $(PRIV_DIR)/dawn_nif.so

all: $(NIF_SO)

$(NIF_SO): $(C_OBJECTS) | $(PRIV_DIR)
	@mkdir -p $(PRIV_DIR)
	$(CXX) $(LDFLAGS) -o $@ $(C_OBJECTS)

$(BUILD_DIR)/dawn_nif.o: $(C_SRC) | $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $< -fno-common

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(PRIV_DIR):
	@mkdir -p $(PRIV_DIR)

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(PRIV_DIR)

