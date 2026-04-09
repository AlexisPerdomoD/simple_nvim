install:
	set -e

	sudo pacman -S --needed --noconfirm git curl neovim ripgrep fd bat fzf go nodejs fnm neovide pnpm zip unzip bash

	############# Java #################
	curl -s "https://get.sdkman.io" | bash
	source "$HOME/.sdkman/bin/sdkman-init.sh"

	sdk install maven
	sdk install java

clean:
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim

clean-all:
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim
	rm -rf ~/.config/nvim
