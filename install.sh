sudo pacman -S --needed --noconfirm git curl neovim ripgrep fd bat fzf go nodejs fnm neovide pnpm

yay -S --needed --noconfirm sdkman
source "$HOME/.sdkman/bin/sdkman-init.sh"
############# Java #################
sdk install maven
sdk install java 15.0.12-tem
sdk install java 17.0.12-tem
sdk install java 21.0.05-tem
