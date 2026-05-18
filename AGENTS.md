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
  opts.lua                ← vim options (4-space indent, expandtab, relativenumber)
  keymaps.lua             ← all global keymaps
  autocmds.lua            ← custom autocmds (yank highlight, spell on .md, centered cursor)
  lazy.lua                ← lazy.nvim bootstrap + `import = 'plugins'`
  neovide.lua             ← Neovide GUI config (font, opacity, scale, JAVA_HOME via SDKMAN)
  plugin/                 ← lspsaga.lua, jdtls.lua (LSP sub-configs)
  themes/                 ← theme definitions; active = nightjungle
lua/plugins/              ← one file per plugin/spec (lazy imports this dir)
lua/utils/                ← bg_color_setuper, custom_spell_check, opencode
lsp/                      ← lua_ls.lua, pyright.lua (standalone LSP configs, referenced by mason)
```

## Key conventions

- **Leader**: `.` (period)
- **Lua style**: 4-space indent, single quotes (see `stylua.toml`)
- **No swapfiles**, undofile enabled, spell off by default (en for `.md` via autocmd)
- Node/python/ruby/perl providers explicitly disabled (`vim.g.loaded_*_provider = 0`)

## LSP

- Servers installed/managed by **Mason** (`lua/plugins/mason.lua`) then enabled via native `vim.lsp.enable()`
- 24 servers configured: ts, go, python, rust, java, lua, web, sql, docker, terraform, etc.
- LSP log level set to `ERROR` (reduces noise)
- Pyright `$/progress` handler suppressed (too verbose)
- Java: **jdtls** with Lombok agent, SDKMAN runtimes (17/21/25), workspace per-project in `stdpath('data')/jdtls-workspace/`
- Lspsaga for enhanced LSP UI (peek definitions, finder, diagnostics)

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
| `<leader>t`        | Toggle transparent background              |
| `<leader>e`        | LSP diagnostic float                       |
| `<leader>L`        | LSP diagnostics loclist                    |
| `<leader>a`        | LSP code action                            |
| `<leader>c`        | Clear search highlight                     |
| `<leader>hs/hr`    | Git stage/reset hunk (gitsigns, buf-local) |
| `sp` (normal)      | Custom spell-check popup                   |
| `<space>oc/of`     | Opencode terminal toggle/focus             |
| `<space><leader>`  | Neo-tree float toggle                      |
| `<space><space>`   | Neo-tree left sidebar                      |
| `<space>b`         | Neo-tree buffers                           |
| `<space>a`         | Harpoon add file                           |
| `<space>e`         | Harpoon menu                               |
| `<space>1-4`       | Harpoon select 1-4                         |
| `<space>s/S`       | Session search/save                        |
| `F`                | Lspsaga finder                             |
| `gd`               | Lspsaga peek definition                    |
| `gr`               | Lspsaga references                         |
| `K`                | Lspsaga hover                              |
| `DE`               | LSP declaration                            |
| `rn`               | LSP rename                                 |
| `td`               | LSP type definition                        |
| Arrow keys         | Blocked in normal mode (prints hint)       |
| `Ctrl-+/Alt-` hjkl | Tmux pane navigation                       |

## Treesitter

- Auto-installs parsers on first use per filetype
- Uses treesitter-based folding (`vim.treesitter.foldexpr()`)
- Skips parsers for UI/plugin buffers (lazy, mason, neo-tree, telescope, noice, etc.)

## Completion (nvim-cmp)

- Sources: LSP > Luasnip > buffer > nerdfonts > path
- Confirm with `Ctrl-Right` or `Ctrl-l` in insert mode
- Autopairs integrated
- cmdline completion for `/`, `?`, `:`

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
