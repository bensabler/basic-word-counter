# Makefile for basic word counter program
#
# Usage:
#   make test
#   make run
#   make build
#   make build-all
#   make clean
#


APP_NAME ?= wc
MAIN_PKG ?= ./cmd/wc

BIN_DIR  ?= bin

GO       ?= go
CGO      ?= 0

# Common cross-compile targets
PLATFORMS := \
	linux/amd64 \
	linux/arm64 \
	darwin/amd64 \
	darwin/arm64 \
	windows/amd64 \
	windows/arm64

.PHONY: help test run build build-all clean

help:
	@echo "Targets:"
	@echo "  make test       - Verbose tests for all packages"
	@echo "  make run        - Run the app (go run)"
	@echo "  make build      - Build for current OS/arch"
	@echo "  make build-all  - Cross-compile for: $(PLATFORMS)"
	@echo "  make clean      - Remove build outputs"
	@echo ""
	@echo "Variables (override like: make build MAIN_PKG=./cmd/myapp):"
	@echo "  APP_NAME=$(APP_NAME)"
	@echo "  MAIN_PKG=$(MAIN_PKG)"
	@echo "  BIN_DIR=$(BIN_DIR)"
	@echo "  CGO=$(CGO)"

test:
	$(GO) test -v ./...

run:
	$(GO) run $(MAIN_PKG)

build:
	@mkdir -p $(BIN_DIR)
	$(GO) build -v -o $(BIN_DIR)/$(APP_NAME) $(MAIN_PKG)

build-all:
	@mkdir -p $(BIN_DIR)
	@for platform in $(PLATFORMS); do \
		os=$${platform%/*}; arch=$${platform#*/}; \
		ext=""; [ "$$os" = "windows" ] && ext=".exe"; \
		out="$(BIN_DIR)/$(APP_NAME)_$${os}_$${arch}$${ext}"; \
		echo "==> Building $$os/$$arch -> $$out"; \
		CGO_ENABLED=$(CGO) GOOS=$$os GOARCH=$$arch \
			$(GO) build -v -o "$$out" $(MAIN_PKG); \
	done

clean:
	@rm -rf $(BIN_DIR)
