local M = { 'neovim/nvim-lspconfig' }
M.dependencies = {
    'williamboman/mason.nvim',
    'nvimdev/lspsaga.nvim',
    'mfussenegger/nvim-jdtls',
    'nvim-tree/nvim-web-devicons',
}

M.event = 'VeryLazy'

M.lsp_servers = {
    'bashls',
    'clangd',
    'csharp_ls',
    'cssls',
    'cssmodules_ls',
    'css_variables',
    'dockerls',
    'golangci_lint_ls',
    'gopls',
    'html',
    'hyprls',
    'jsonls',
    'lua_ls',
    'marksman',
    'postgres_lsp',
    'pyright',
    'ruff',
    'rust_analyzer',
    'sqlls',
    'tailwindcss',
    'terraformls',
    'ts_ls',
    'eslint',
    'vue_ls',
    'yamlls',
}

M.config = function()
    vim.lsp.log.set_level 'ERROR'

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
            local bufnr = args.buf
            local opts = { buffer = bufnr, noremap = true, silent = true }
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' -- algo de autocompletadito
            vim.keymap.set('n', '.e', vim.diagnostic.open_float)
            vim.keymap.set('n', '.L', vim.diagnostic.setloclist)
            vim.keymap.set('n', 'DE', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader><leader>', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>hs', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
                local wdirs = vim.inspect(vim.lsp.buf.list_workspace_folders())
                vim.notify(wdirs, vim.log.levels.INFO, { title = 'working dirs' })
            end, opts)
            vim.keymap.set('n', 'td', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<space>l', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }, { bufnr = bufnr })
            end, opts)

            -- SAGA KEYMAPS
            vim.keymap.set('n', '<space>[', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
            vim.keymap.set('n', '<space>]', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
            vim.keymap.set('n', 'F', '<cmd>Lspsaga finder<CR>', opts)
            vim.keymap.set('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts)
            vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
            vim.keymap.set('n', 'ca', '<cmd>Lspsaga code_action<CR>', opts)
            vim.keymap.set('n', 'gr', '<cmd>Lspsaga finder ref<CR>', opts)
            vim.keymap.set('n', '<space>wd', '<cmd>Lspsaga show_workspace_diagnostics<CR>', opts)
            vim.keymap.set('n', '<space>wb', '<cmd>Lspsaga show_buf_diagnostics<CR>', opts)
        end,
    })

    for _, server_name in ipairs(M.lsp_servers) do
        vim.lsp.enable(server_name)
    end

    -- LSPSAGA CONFIGURATION
    local lspsaga_config = require 'config.plugin.lspsaga'
    require('lspsaga').setup(lspsaga_config)

    -- JAVA LSP AUTOCOMAND SPECIFIC CONFIGURATION
    local jdtls = require 'jdtls'
    local jdtls_setup_config = require('config.plugin.jdtls'):get_config(M.extendedClientCapabilities)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'java',
        callback = function()
            jdtls.start_or_attach(jdtls_setup_config)
        end,
    })

    -- OVERRRIDES
    local default_progress_handler = vim.lsp.handlers['$/progress'] or function(_, _, _) end

    vim.lsp.handlers['$/progress'] = function(err, result, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if not client then
            return
        end

        if client.name == 'pyright' then
            -- MOLESTO
            return
            -- local value = result and result.value
            -- if type(value) == 'table' and type(value.message) == 'string' and value.message:find 'analyze' then return end
        end

        return default_progress_handler(err, result, ctx)
    end
end

return M
