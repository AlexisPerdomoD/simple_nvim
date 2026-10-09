# AGENTS.md — Neovim config

## Repo identity

- Personal Neovim config at `~/.config/nvim`
- Lua-only, lazy.nvim plugin manager, no VimScript
- OS: Arch Linux (packages via `pacman` in Makefile)

## Quick commands

| Action                | Command                          |
| --------------------- | -------------------------------- |
| Install deps          | `make install`                   |
| Wipe state            | `make clean`                     |
| Wipe config too       | `make clean-all`                 |
| Reload config in nvim | `<leader>1` (sources `init.lua`) |
| Format file/range     | `<leader>s`                      |

## Architecture

```
init.lua                  ← entrypoint (loads opts → autocmds → keymaps → lazy)
lua/config/
  opts.lua                ← Neovim options and native completion/diagnostic UI
  keymaps.lua             ← all global keymaps
  autocmds.lua            ← custom autocmds (yank highlight, spell on .md, centered cursor)
  lazy.lua                ← lazy.nvim bootstrap + `import = 'plugins'`
  neovide.lua             ← Neovide GUI config (font, opacity, scale, JAVA_HOME via SDKMAN)
  plugin/                 ← JDTLS sub-configuration
  themes/                 ← theme definitions; active = poimandres
lua/plugins/              ← one file per plugin/spec (lazy imports this dir)
lua/utils/                ← custom_spell_check, file_size, opencode
lsp/                      ← lua_ls.lua, pyright.lua (standalone LSP configs, referenced by mason)
```

## Key conventions

- **Leader**: `.` (period)
- **Lua style**: 4-space indent, single quotes (see `stylua.toml`)
- **No swapfiles**, undofile enabled, spell off by default (en for `.md` via autocmd)
- Node/python/ruby/perl providers explicitly disabled (`vim.g.loaded_*_provider = 0`)

## LSP

- Tested with Neovim 0.12.5; uses native LSP and completion APIs.
- Servers installed/managed by **Mason** (`lua/plugins/mason.lua`) and enabled with `vim.lsp.enable()`.
- 16 servers are enabled in `lua/plugins/lspconfig.lua`; Java uses `nvim-jdtls` separately.
- Native LSP completion is manual (`<C-Space>`) to avoid unsolicited insert-mode popups; nvim-cmp is not configured.
- Native snippets use `vim.snippet`; `<C-j>/<C-k>` navigate placeholders and `<M-s>` inserts a test snippet in insert mode.
- LSP maps are buffer-local and installed according to client method support in `LspAttach`.
- LSP log level set to `ERROR` (reduces noise)
- Pyright `$/progress` handler suppressed (too verbose)
- Java: **jdtls** with Lombok agent, SDKMAN runtimes (17/21/25), workspace per-project in `stdpath('data')/jdtls-workspace/`
- Diagnostics use signs and on-demand floats; virtual text is disabled to reduce inline noise.

## Formatting (conform.nvim)

- Prettier for JS/TS/JSX/TSX/Vue/CSS/HTML/JSON/Markdown
- Stylua for Lua (uses `--search-parent-directories`)
- Ruff format for Python, gofumpt for Go, shfmt for shell, csharpier for C#, clang_format for C/C++
- SQLFluff for SQL, yamlfmt for YAML, xmlformat for XML
- Java uses `lsp_format = 'first'`
- Prettier falls back to `~/.config/nvim/default_dev_config/.prettierrc.json` if no project config found

## Keymaps (non-obvious ones)

| Keys               | Action                                     |
| ------------------ | ------------------------------------------ |
| `<leader>1`        | Reload entire config                       |
| `<leader>s`        | Format file                                |
| `<M-s>`            | Insert native snippet test (insert mode)   |
| `<leader>e`        | LSP diagnostic float                       |
| `<leader>L`        | LSP diagnostics loclist                    |
| `cA`               | LSP code action                            |
| `<leader>c`        | Clear search highlight                     |
| `<leader>hs/hr`    | Git stage/reset hunk (gitsigns, buf-local) |
| `sp` (normal)      | Custom spell-check popup                   |
| `<space>oc/of`     | Opencode terminal toggle/focus             |
| `<space><leader>`  | Neo-tree float toggle                      |
| `<space><space>`   | Neo-tree left sidebar                      |
| `<space>b`         | Neo-tree buffers                           |
| `<space>s/S`       | Session search/save                        |
| `<C-Space>`        | Request native LSP completion              |
| `<C-j>/<C-k>`      | Snippet placeholders; otherwise move vertically |
| `DE/gd/td/gi/grr`  | Supported LSP navigation methods           |
| `<leader><leader>` | LSP hover                                  |
| `<leader>sh`       | LSP signature help                         |
| `rn`               | LSP rename                                 |
| `<space>l`         | Toggle supported LSP inlay hints           |
| Arrow keys         | Blocked in normal mode (prints hint)       |
| `Alt-hjkl`         | Split navigation                           |

## Treesitter

- Auto-installs parsers on first use per filetype
- Uses treesitter-based folding (`vim.treesitter.foldexpr()`)
- Skips parsers for UI/plugin buffers (lazy, mason, neo-tree, telescope, noice, etc.)

## Completion and snippets (native Neovim)

- `vim.o.autocomplete = false`; request LSP completion with `<C-Space>`.
- `completeopt` keeps the native menu unselected and does not insert candidates automatically.
- `vim.snippet` handles placeholders; no snippet plugin/catalog is enabled.
- Completion sources are attached LSPs; nvim-cmp buffer/path/cmdline sources are not configured.

## AI

- **Supermaven** (free version) for inline completion
- Accept: `Ctrl-a`, clear: `Ctrl-]`, accept word: `Ctrl-w`
- Disabled for C++ files

## Neovide (GUI)

- Font: FantasqueSansM Nerd Font :h11
- `Ctrl-+/-`: scale, `Ctrl-)/(`: opacity
- Sets `JAVA_HOME` to SDKMAN current via `neovide.lua`
- System clipboard paste via `Cmd-v` / `Ctrl-Shift-v`

## Sessions

- auto-session: auto-save enabled, auto-restore **disabled**
- Suppressed dirs: `~/work`, `~/.config/*`
