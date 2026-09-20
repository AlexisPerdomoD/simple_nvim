PACMAN := sudo pacman -S --needed --noconfirm

BASE_PACKAGES := git \
	curl \
	neovim \
	ripgrep \
	fd \
	bat \
	fzf \
	go \
	nodejs \
	fnm \
	neovide \
	pnpm \
	zip \
	unzip \
	bash \
	tree-sitter \
	tree-sitter-cli

# Rust: cargo/rustc/rustfmt/clippy come del paquete `rust`.
# `rust-src` es requerido por rust-analyzer (fuentes de la std).
RUST_PACKAGES := rust rust-src

# Runtimes base; los LSPs y formatters (pyright, ruff) los gestiona Mason.
PYTHON_PACKAGES := python uv

.PHONY: install install-base install-rust install-python install-java check-deps clean clean-all

install: install-base install-rust install-python

install-base:
	$(PACMAN) $(BASE_PACKAGES)

install-rust:
	$(PACMAN) $(RUST_PACKAGES)

install-python:
	$(PACMAN) $(PYTHON_PACKAGES)

install-java:
	set -e

	curl -s "https://get.sdkman.io" | bash

	# Se mantiene la sesion de shell para que el `source` persista en los `sdk`.
	bash -c '
	    source "${HOME}/.sdkman/bin/sdkman-init.sh"
	    sdk install maven
	    sdk install java
	'

check-deps:
	@echo "== Rust =="
	@command -v cargo >/dev/null && cargo --version || echo "Falta: cargo (paquete rust)"
	@command -v rustfmt >/dev/null && rustfmt --version || echo "Falta: rustfmt (paquete rust)"
	@test -d "$$(rustc --print sysroot)/lib/rustlib/src/rust/library" \
		&& echo "rust-src: OK (rust-analyzer podra cargar la std)" \
		|| echo "Falta: rust-src"
	@echo "== Python =="
	@command -v python >/dev/null && python --version || echo "Falta: python"
	@command -v uv >/dev/null && uv --version || echo "Falta: uv (paquete python-uv)"
	@echo "== Java =="
	@command -v java >/dev/null && java --version | head -n 1 || echo "Falta: Java (ejecuta make install-java)"
	@command -v javac >/dev/null && javac --version || echo "Falta: JDK (ejecuta make install-java)"
	@command -v mvn >/dev/null && mvn --version | head -n 1 || echo "Falta: Maven (ejecuta make install-java)"
	@test -n "$$SDKMAN_DIR" && echo "SDKMAN: OK ($$SDKMAN_DIR)" || echo "Falta: SDKMAN"
	@echo "== Base =="
	@command -v nvim >/dev/null && nvim --version | head -n 1 || echo "Falta: neovim"

clean:
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim

clean-all:
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim
	rm -rf ~/.config/nvim
