# Minimalistic Neovim Configuration

A clean, fast, and efficient Neovim configuration using lazy.nvim as the package manager. This configuration aims to provide a streamlined development environment while maintaining simplicity and performance.

## Features

- 🚀 Fast startup time
- 📦 Lazy-loaded plugins
- 🎨 Modern plugin ecosystem
- 🛠 Minimal yet functional setup

## Prerequisites

Before using this configuration, ensure you have the following installed:

- [Neovim](https://neovim.io/) (v0.12.0 or later; native LSP completion APIs are used)
- [Node.js](https://nodejs.org/) and npm (for LSP support)
- [Go](https://golang.org/) (for Go development tools)
- [git](https://git-scm.com/) (for plugin management)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, but recommended for icons)

## Installation

1. Backup your existing Neovim configuration (if any):

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. Clone this repository:

```bash
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
```

3. Start Neovim:

```bash
nvim
```

The configuration will automatically:

- Install lazy.nvim (package manager)
- Download and install all configured plugins
- Set up language servers and completions

## Key Features

- File explorer
- Code completion
- LSP support
- Fuzzy finding
- Git integration
- Syntax highlighting
- Modern UI

## Structure

```
~/.config/nvim/
├── init.lua
├── lazy-lock.json
└── lua/
    └── config/
        ├── plugins/
        ├── keymaps.lua
        └── options.lua
```

## Customization

You can customize this configuration by:

1. Modifying plugin settings in `lua/config/plugins/`
2. Adjusting keymaps in `lua/config/keymaps.lua`
3. Changing Neovim options in `lua/config/options.lua`

## Contributing

Feel free to fork this repository and submit pull requests for improvements.

## License

MIT

## Acknowledgments

- [Neovim](https://neovim.io/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- All plugin authors who make this configuration possible
