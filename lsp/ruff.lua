---@type vim.lsp.Config
return {
    cmd = { 'ruff', 'server' },
    -- workspace_required = false,
    filetypes = { 'python' },
    -- root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },

    settings = {
        configurationPreference = 'filesystem',

        lint = {
            enable = true,
        },

        -- format = {
        --     enable = false, -- cambia a true si quieres Ruff formatter
        -- },

        organizeImports = true,
        fixAll = true,
    },

    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if fname == '' or not vim.api.nvim_buf_is_valid(bufnr) then
            on_dir(vim.fn.getcwd())
            return
        end

        local root = vim.fs.root(fname, {
            'pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'ruff.toml',
            '.git',
        })

        on_dir(root or vim.fs.dirname(fname))
    end,

    on_attach = function(_, bufnr)
        ----------------------------------------------------------------
        -- Autofix Ruff on save
        ----------------------------------------------------------------
        -- local group = vim.api.nvim_create_augroup('ruff_fix_' .. bufnr, { clear = true })

        -- vim.api.nvim_create_autocmd('BufWritePre', {
        --     group = group,
        --     buffer = bufnr,
        --     callback = function()
        --         -- asegurar que Ruff sigue attached
        --         local ruff_clients = vim.lsp.get_clients {
        --             bufnr = bufnr,
        --             name = 'ruff',
        --         }
        --
        --         if #ruff_clients == 0 then return end
        --
        --         vim.lsp.buf.code_action {
        --             context = {
        --                 diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
        --                 only = { 'source.fixAll.ruff' },
        --             },
        --             apply = true,
        --         }
        --     end,
        -- })

        -- vim.api.nvim_create_autocmd('BufWritePre', {
        --     group = group,
        --     buffer = bufnr,
        --     callback = function()
        --         if not vim.api.nvim_buf_is_valid(bufnr) then return end
        --
        --         local clients = vim.lsp.get_clients { bufnr = bufnr, name = 'ruff' }
        --         if #clients == 0 then return end
        --
        --         pcall(
        --             function()
        --                 vim.lsp.buf.code_action {
        --                     context = { diagnostics = vim.diagnostic.get(bufnr), only = { 'source.fixAll.ruff' } },
        --                     apply = true,
        --                 }
        --             end
        --         )
        --     end,
        -- })

        ----------------------------------------------------------------
        -- Organize imports manual command (opcional)
        ----------------------------------------------------------------
        -- vim.api.nvim_buf_create_user_command(
        --     bufnr,
        --     'RuffOrganizeImports',
        --     function()
        --         vim.lsp.buf.code_action {
        --             context = {
        --                 diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
        --                 only = { 'source.organizeImports.ruff' },
        --             },
        --             apply = true,
        --         }
        --     end,
        --     { desc = 'Ruff organize imports' }
        -- )
        vim.api.nvim_buf_create_user_command(bufnr, 'RuffOrganizeImports', function()
            if not vim.api.nvim_buf_is_valid(bufnr) then return end

            local clients = vim.lsp.get_clients { bufnr = bufnr, name = 'ruff' }
            if #clients == 0 then return end
            pcall(
                function()
                    vim.lsp.buf.code_action {
                        context = {
                            diagnostics = vim.diagnostic.get(bufnr),
                            only = { 'source.organizeImports.ruff' },
                        },
                        apply = true,
                    }
                end
            )
        end, { desc = 'Ruff organize imports' })
    end,
}
