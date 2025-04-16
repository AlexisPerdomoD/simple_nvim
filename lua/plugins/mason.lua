return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",

    },
    lazy = true,
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "lua_ls",
                "cssls",
                "cssmodules_ls",
                "css_variables",
                "golangci_lint_ls",
                "gopls",
                "html",
                "jsonls",
                "markdown_oxide",
                "sqls",
                "yamlls",
                'tailwindcss',
                'omnisharp',
                'tsserver',

                -- 'csharp_ls', lighttier alternative to omnisharp but less compatibility
                -- does not work for formaters
                -- list for formnaters and linters reference
                --'CSharpier'
                --"eslint_d",
                --"prettier",
                --"yamlfmt",
                --"shfmt",
                --"stylua",
                --or linters
                --'vale',
            },
            automatic_installation = true,
        }
        )
    end,
}

-- bash-language-server
--     ◍ css-lsp
--     ◍ css-variables-language-server
--     ◍ eslint_d
--     ◍ golangci-lint
--     ◍ golangci-lint-langserver
--     ◍ google-java-format
--     ◍ gopls
--     ◍ html-lsp
--     ◍ htmlhint
--     ◍ json-lsp
--     ◍ lua-language-server
--     ◍ markdown-oxide
--     ◍ prettier
--     ◍ shfmt
--     ◍ stylua
--     ◍ typescript-language-server
--     ◍ yaml-language-server
--     ◍ yamlfmt
