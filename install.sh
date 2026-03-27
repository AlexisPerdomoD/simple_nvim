#!/bin/env bash
set -e

sudo pacman -S --needed --noconfirm git curl neovim ripgrep fd bat fzf go nodejs fnm neovide pnpm zip unzip bash

############# Java #################
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install maven
sdk install java
