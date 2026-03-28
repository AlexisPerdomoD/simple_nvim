---@type vim.lsp.Config
local Config = {
    cmd = { 'ruff', 'server' },
    -- workspace_required = false,
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },

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

    on_attach = function(_, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'RuffOrganizeImports', function()
            if not vim.api.nvim_buf_is_valid(bufnr) then return end

            vim.lsp.buf.code_action {
                context = {
                    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
                    only = { 'source.organizeImports.ruff' },
                },
                apply = true,
            }
        end, { desc = 'Ruff organize imports' })
    end,
}

return Config
