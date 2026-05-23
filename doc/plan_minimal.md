# Plan de mejora progresiva — simple_nvim

> Contexto: Neovim 0.12.x | ~40 plugins | objetivo: reducir overhead manteniendo experiencia completa

---

## ✅ Completado (23 may 2026)

### Fase 1 — Quick wins

#### 1.1 LSP servers auditados

Servidores desactivados (comentados en `lspconfig.lua` y `mason.lua`):

| Server                     | Motivo                     |
| -------------------------- | -------------------------- |
| `csharp_ls`                | No usas C#                 |
| `cssmodules_ls`            | Remplazable por cssls      |
| `css_variables_ls`         | Remplazable por cssls      |
| `golangci_lint_ls`         | gopls ya lint-ea           |
| `marksman`                 | Markdown pesado            |
| `postgres_lsp`             | Base de datos diaria?      |
| `sqls` / `sqlls`           | SQL diario?                |
| `terraformls`              | Infra diaria?              |
| `vue_ls`                   | Vue diario?                |

#### 1.2 Mason sincronizado con lspconfig

#### 1.3 Keymap `<leader>R` para restart — pendiente (no implementado)

### Fase 2 — ✅ lspsaga eliminado

- Eliminado `config/plugin/lspsaga.lua`
- Eliminado de dependencies en `lspconfig.lua`
- Keymaps reemplazados por LSP nativo + telescope

**Reemplazos aplicados:**

| Feature lspsaga              | Reemplazo actual                         |
| ---------------------------- | ---------------------------------------- |
| `peek_definition` (gd)       | `vim.lsp.buf.definition` (`gd`)          |
| `finder` (F, gr)             | `vim.lsp.buf.references` (`grr`) / telescope (`<space>gR`) |
| `hover_doc` (K)              | `vim.lsp.buf.hover` (`<leader><leader>`) |
| `diagnostic_jump`            | `vim.diagnostic.jump()` (`<leader>[` / `<leader>]`) |
| `show_workspace_diagnostics` | telescope `<space>wd` / `<space>wb`      |
| `code_action` (cA)           | `vim.lsp.buf.code_action` (`cA`)         |

### Fase 3 — ✅ noice eliminado por completo (Opción B)

- Eliminado `lua/plugins/noice.lua`
- Reemplazado por `nvim-notify` standalone (`lua/plugins/notify.lua`)
- Configuración minimalista: merge_duplicates, render minimal, fade animation

### Bonus — Limpieza adicional

| Plugin eliminado               | Motivo                                   |
| ------------------------------ | ---------------------------------------- |
| `vim-tmux-navigator`           | Reemplazado por `<C-w>` splits nativos   |
| `Comment.nvim`                 | No se usaba activamente                  |
| `rafamadriz/friendly-snippets` | Dependencia no crítica de LuaSnip        |
| `nightjungle` theme            | Ya no era el tema activo (→ vercel)      |

**Keymaps de navegación migrados:**
- `Alt-h/j/k/l` ahora hacen `<C-w>h/j/k/l` (splits nativos) en normal y terminal mode
- Eliminados `vim-tmux-navigator` commands

**jdtls movido** de `lspconfig.lua` → `extras.lua` con config más limpia (sin dependencia directa).

---

## Pendientes

### Fase 4 — Evaluar autocomplete nativo

> Base estable después de fases 1-3

Actualmente: `nvim-cmp` + 6 sources + `cmp_luasnip`.

```lua
vim.o.autocomplete = true  -- completion LSP básico nativo en 0.12
```

| Opción        | Trade-off                               |
| ------------- | --------------------------------------- |
| Nativo (0.12) | -9 plugins, menos íconos, sin cmdline   |
| blink.cmp     | Más ligero que nvim-cmp, compatible LSP |
| Quedarse cmp  | Estable, familiar, cmdline completion   |

### Fase 5 — vim.park (futuro, no antes de 0.13)

Aún experimental. Revisar cuando:
- `vim.pack` salga de experimental
- Tenga lazy-loading comparable al de lazy.nvim
- Neovim 0.13 esté estable

---

## Resumen de impacto real

| Fase                          | Esfuerzo | Impacto real                        |
| ----------------------------- | -------- | ----------------------------------- |
| 1 — Auditar LSP               | Bajo     | Alto (menos ruido en restart)       |
| 2 — Eliminar lspsaga          | Medio    | Medio (~196 líneas, 1 plugin menos) |
| 3 — Eliminar noice            | Medio    | Alto (~317 líneas, 1 plugin menos)  |
| 4 — Autocomplete nativo       | —        | Pendiente                           |
| 5 — vim.pack                  | —        | Pendiente                           |
| **Bonuses** (tmux, comment, etc) | Bajo  | ~4 plugins menos, splits nativos    |

**Total: ~700 líneas eliminadas, ~100 añadidas, 5 plugins eliminados.**

