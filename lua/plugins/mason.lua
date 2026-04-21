local M = { 'williamboman/mason.nvim' }
M.ensure_installed = {
    'typescript-language-server',
    'bash-language-server',
    'lua-language-server',
    'css-lsp',
    'cssmodules-language-server',
    'css-variables-language-server',
    'golangci-lint-langserver',
    'gopls',
    'html-lsp',
    'json-lsp',
    'marksman',
    'sqls',
    'yaml-language-server',
    'tailwindcss-language-server',
    'rust-analyzer',
    'csharp-language-server',
    'csharpier',
    'yamlfmt',
    'shfmt',
    'stylua',
    'jdtls',
    'eslint-lsp',
    'pyright',
    'ruff',

    -- formaters
    'prettier',
    'stylua',
    'shfmt',
}

M.event = 'VeryLazy'
M.config = function()
    local mason = require 'mason'
    mason.setup {}
    local register = require 'mason-registry'

    for _, server_name in ipairs(M.ensure_installed) do
        if register.is_installed(server_name) then
            goto continue
        end

        register.get_package(server_name):install()
        vim.notify('Installed ' .. server_name, vim.log.levels.INFO, { title = 'LSP Server Install' })

        ::continue::
    end
end

return M
