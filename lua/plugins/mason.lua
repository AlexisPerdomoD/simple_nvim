return {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
        require("mason").setup()

        local mason_registry = require("mason-registry")
        local manual_ensure_installed = function(server_name)
            if not mason_registry.is_installed(server_name) then
                mason_registry.get_package(server_name):install()
                print("Installed " .. server_name)
            end
        end

        local ensure_installed = {
            "typescript-language-server",
            "bash-language-server",
            "lua-language-server",
            "css-lsp",
            "cssmodules-language-server",
            "css-variables-language-server",
            "golangci-lint-langserver",
            "gopls",
            "html-lsp",
            "json-lsp",
            "marksman",
            "sqls",
            "yaml-language-server",
            "tailwindcss-language-server",
            "csharp-language-server",
            "csharpier",
            "eslint_d",
            "prettier",
            "yamlfmt",
            "shfmt",
            "stylua",
        }

        for _, server_name in ipairs(ensure_installed) do
            manual_ensure_installed(server_name)
        end
    end,
}
