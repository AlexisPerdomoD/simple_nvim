local M = { 'neovim/nvim-lspconfig' }

M.event = 'VeryLazy'

M.lsp_servers = {
    'ts_ls',
    'bashls',
    'cssls',
    'dockerls',
    'eslint_ls',
    'gopls',
    'html',
    'jsonls',
    'lua_ls',
    'pyright',
    'ruff',
    'rust_analyzer',
    'tailwindcss',
    'yamlls',
    'hyprls',
    'clangd',
    -- 'csharp_ls',   -- C#?
    -- 'vue_ls',      -- Vue?
    -- 'marksman',    -- Markdown pesado?
    -- 'golangci_lint_ls', -- gopls ya lint-ea
    -- 'sqlls',       -- SQL diario?
}

M.config = function()
    vim.lsp.log.set_level 'ERROR'

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
            local bufnr = args.buf
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' -- algo de autocompletadito

            -- DIAGNOSTICS
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '<leader>L', vim.diagnostic.setloclist, opts)
            vim.keymap.set('n', '<leader>[', function()
                vim.diagnostic.jump { count = -1 }
            end, opts)
            vim.keymap.set('n', '<leader>]', function()
                vim.diagnostic.jump { count = 1 }
            end, opts)

            -- NAVIGATION
            vim.keymap.set('n', 'DE', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'td', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)

            -- HOVER / SIGNATURE HELP
            vim.keymap.set('n', '<leader><leader>', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>hs', vim.lsp.buf.signature_help, opts)

            -- CODE ACTIONS
            vim.keymap.set('n', 'cA', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)

            -- WORKSPACE
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)

            vim.keymap.set('n', '<space>wl', function()
                local wdirs = vim.inspect(vim.lsp.buf.list_workspace_folders())
                vim.notify(wdirs, vim.log.levels.INFO, { title = 'working dirs' })
            end, opts)
            vim.keymap.set('n', '<space>l', function()
                local is_active = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
                vim.lsp.inlay_hint.enable(not is_active, { bufnr = bufnr })
            end, opts)
        end,
    })

    for _, server_name in ipairs(M.lsp_servers) do
        vim.lsp.enable(server_name)
    end
end

return M
