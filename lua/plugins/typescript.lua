return {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    -- config = function()
    --     local api = require("typescript-tools.api")
    --     require("typescript-tools").setup({
    --         on_attach = function(_, bufnr)
    --             vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' -- algo de autocompletadito
    --             local opts = { buffer = bufnr }
    --             vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --             vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    --             vim.keymap.set('n', '..', vim.lsp.buf.hover, opts)
    --             vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    --             vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    --             vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --             vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --             vim.keymap.set('n', '<space>wl', function()
    --                 print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --             end, opts)
    --             vim.keymap.set('n', 'td', vim.lsp.buf.type_definition, opts)
    --             vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
    --             vim.keymap.set({ 'n', 'v' }, 'ca', vim.lsp.buf.code_action, opts)
    --             vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --             -- code actions
    --             -- vim.keymap.set({ 'n', 'v' }, '.ca', vim.lsp.buf.code_action, opts)
    --             --vim.keymap.set('n', '<leader>f', function()
    --             --  vim.lsp.buf.format { async = true }
    --             --end, opts)
    --         end,
    --         handlers = {
    --             ["textDocument/publishDiagnostics"] = api.filter_diagnostics(
    --             -- Ignorar diagnósticos de información específicos.
    --                 { 80006, 80007 } -- Ejemplo de códigos de diagnóstico para información que deseas ignorar
    --             ),
    --         },
    --         settings = {
    --             -- spawn additional tsserver instance to calculate diagnostics on it
    --             separate_diagnostic_server = true,
    --             -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    --             publish_diagnostic_on = "change",
    --             -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    --             -- "remove_unused_imports"|"organize_imports") -- or string "all"
    --             -- to include all supported code actions
    --             -- specify commands exposed as code_actions
    --             expose_as_code_action = {},
    --             -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    --             -- not exists then standard path resolution strategy is applied
    --             tsserver_path = nil,
    --             -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    --             -- (see 💅 `styled-components` support section)
    --             tsserver_plugins = {},
    --             -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    --             -- memory limit in megabytes or "auto"(basically no limit)
    --             tsserver_max_memory = "auto",
    --             -- described below
    --             tsserver_format_options = {},
    --             tsserver_file_preferences = {},
    --             -- locale of all tsserver messages, supported locales you can find here:
    --             -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    --             tsserver_locale = "en",
    --             -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    --             complete_function_calls = false,
    --             include_completions_with_insert_text = true,
    --             -- CodeLens
    --             -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    --             -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    --             code_lens = "off",
    --             -- by default code lenses are displayed on all referencable values and for some of you it can
    --             -- be too much this option reduce count of them by removing member references from lenses
    --             disable_member_code_lens = true,
    --             -- JSXCloseTag
    --             -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
    --             -- that maybe have a conflict if enable this feature. )
    --             jsx_close_tag = {
    --                 enable = false,
    --                 filetypes = { "javascriptreact", "typescriptreact" },
    --             }
    --         },
    --
    --
    --
    --     })
    -- end,
}
