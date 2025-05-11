local default_setup = function(on_attach, capabilities)
    return { capabilities = capabilities, on_attach = on_attach }
end
local minimal_setup = function(on_attach, capabilities) return { capabilities = capabilities } end

local markdown_setup = function(on_attach, capabilities)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes =
        ".md"
    }
end

local lua_setup = function(on_attach, capabilities)
    return {
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                    version = "LuaJIT",
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
            })
        end,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    path = vim.split(package.path, ";"),
                },
                diagnostic = {
                    globals = { "vim" },
                },
                telemetry = { enable = false },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                    maxPreload = 2000,
                    preLoadFileSize = 1000,
                },
            },
        },
    }
end

local bash_setup = function(on_attach, capabilities)
    return {
        filetypes = { "sh", "bash", "zsh" }, -- Incluye Bash y Zsh
        cmd = { "bash-language-server", "start" },
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

local ts_setup = function(on_attach, capabilities)
    return {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = "",
                    languages = { "vue" },
                },
            },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    }
end

local vue_setup = function()
    return {
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
            vue = {
                hybridMode = true,
            },
        },
    }
end

local html_setup = function(on_attach, capabilities)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        options = {
            filetype = { "html", "templ", "handlebars", ".handlebars" },
        },
    }
end

local sql_setup = function(on_attach, capabilities)
    return {
        on_attach = on_attach,
        settings = {
            sqlls = {
                formatter = { command = "sql-formatter" },
            },
        },
    }
end

local golang_setup = function(on_attach, capabilities, util)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        cmd = { "gopls", "serve" },
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    }
end

local golangci_lint_setup = function(on_attach, capabilities, util)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "golangci-lint-langserver" },
        filetypes = { "go", "gomod" },
        root_dir = util.root_pattern(".golangci.yml", ".golangci.yaml", ".golangci.toml", ".golangci.json", "go.work",
            "go.mod", ".git"),
    }
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        -- 'Hoffs/omnisharp-extended-lsp.nvim',
        "decodetalkers/csharpls-extended-lsp.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvimdev/lspsaga.nvim",
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    event = "VeryLazy",
    config = function()
        require("neodev").setup()

        local saga_config = {
            virtual_text = true,
            ui = { border = "rounded", code_action = "⚡" },
            diagnostic = { on_insert = false, border_follow = true, diagnostic_only_current = false },
            lightbulb = { enable = true, virtual_text = false },
            symbol_in_winbar = { enable = true, hide_keyword = true, },
        }

        require("lspsaga").setup(saga_config)
        local config = require 'lspconfig'
        local utils = config.util
        local cs_extensions = require('csharpls_extended')
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local on_attach = function(_, bufnr)
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc" -- algo de autocompletadito
            local opts = { buffer = bufnr, noremap = true, silent = true }
            -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", ".e", vim.diagnostic.open_float)
            vim.keymap.set("n", "<space>[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
            vim.keymap.set("n", "<space>]", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
            vim.keymap.set("n", ".L", vim.diagnostic.setloclist)

            vim.keymap.set("n", "F", "<cmd>Lspsaga lsp_finder<CR>", opts)
            vim.keymap.set("n", "DE", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "..", "<cmd>Lspsaga hover_doc<CR>", opts)

            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set("n", "td", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "ca", "<cmd>Lspsaga code_action<CR>", opts)
            vim.keymap.set("n", "gr", "<cmd>Lspsaga finder ref<CR>", opts)
        end

        config.lua_ls.setup(lua_setup(on_attach, capabilities))
        config.bashls.setup(bash_setup(on_attach, capabilities))
        config.ts_ls.setup(ts_setup(on_attach, capabilities))
        config.angularls.setup(default_setup(on_attach, capabilities))
        config.volar.setup(vue_setup())
        config.html.setup(html_setup(on_attach, capabilities))
        config.cssls.setup(default_setup(on_attach, capabilities))
        config.css_variables.setup(default_setup(on_attach, capabilities))
        config.tailwindcss.setup(default_setup(on_attach, capabilities))
        config.marksman.setup(markdown_setup(on_attach, capabilities))
        config.jsonls.setup(default_setup(on_attach, capabilities))
        config.sqlls.setup(sql_setup(on_attach, capabilities))
        config.yamlls.setup(minimal_setup(on_attach, capabilities))
        config.gopls.setup(golang_setup(on_attach, capabilities, utils))
        config.golangci_lint_ls.setup(golangci_lint_setup(on_attach, capabilities, utils))
        -- config.omnisharp.setup(cs_setup(on_attach, capabilities, config.util, cs_extensions))
        config.csharp_ls.setup(default_setup(on_attach, capabilities))
        cs_extensions.buf_read_cmd_bind()
        config.hyprls.setup(default_setup(on_attach, capabilities))

        vim.diagnostic.config({ virtual_text = true })
    end,
}
