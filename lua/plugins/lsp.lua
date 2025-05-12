local default_setup = function(on_attach, capabilities)
    return { capabilities = capabilities, on_attach = on_attach }
end
local minimal_setup = function(on_attach, capabilities) return { capabilities = capabilities } end

local markdown_setup = function(on_attach, capabilities)
    return {
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = ".md",
    }
end

local lua_setup = function(on_attach, capabilities)
    return {
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    vim.uv.fs_stat(path .. "/.luarc.json")
                    or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                then
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
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
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
        root_dir = util.root_pattern(
            ".golangci.yml",
            ".golangci.yaml",
            ".golangci.toml",
            ".golangci.json",
            "go.work",
            "go.mod",
            ".git"
        ),
    }
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "decodetalkers/csharpls-extended-lsp.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "nvimdev/lspsaga.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
        local saga_config = {
            virtual_text = true,
            ui = { border = "rounded", code_action = "⚡" },
            diagnostic = {
                on_insert = false,
                border_follow = true,
                diagnostic_only_current = false,
            },
            lightbulb = { enable = true, virtual_text = false },
            symbol_in_winbar = { enable = true, hide_keyword = true },
        }

        require("lspsaga").setup(saga_config)
        local config = require("lspconfig")
        local utils = config.util
        local cs_extensions = require("csharpls_extended")
        local capabilities = require("cmp_nvim_lsp").default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )

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
            vim.keymap.set(
                "n",
                "<space>wl",
                function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                opts
            )
            vim.keymap.set("n", "td", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "ca", "<cmd>Lspsaga code_action<CR>", opts)
            vim.keymap.set("n", "gr", "<cmd>Lspsaga finder ref<CR>", opts)
        end

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my.lsp", {}),
            callback = function(args)
                local bufnr = args.buf
                local opts = { buffer = bufnr, noremap = true, silent = true }
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc" -- algo de autocompletadito
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
                vim.keymap.set(
                    "n",
                    "<space>wl",
                    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                    opts
                )
                vim.keymap.set("n", "td", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "ca", "<cmd>Lspsaga code_action<CR>", opts)
                vim.keymap.set("n", "gr", "<cmd>Lspsaga finder ref<CR>", opts)

                if client:supports_method("textDocument/implementation") then
                    -- Create a keymap for vim.lsp.buf.implementation ...
                end
                -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
                if client:supports_method("textDocument/completion") then
                    -- Optional: trigger autocompletion on EVERY keypress. May be slow!
                    -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
                    -- client.server_capabilities.completionProvider.triggerCharacters = chars
                    -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                end
                -- Auto-format ("lint") on save.
                -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
                if
                    not client:supports_method("textDocument/willSaveWaitUntil")
                    and client:supports_method("textDocument/formatting")
                then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({
                                bufnr = args.buf,
                                id = client.id,
                                timeout_ms = 1000,
                            })
                        end,
                    })
                end
            end,
        })

        vim.lsp.enable("lua_ls")
        vim.lsp.enable("bash_ls")
        vim.lsp.enable("ts_ls")
        vim.lsp.enable("angular_ls")
        vim.lsp.enable("html_ls")
        vim.lsp.enable("css_ls")
        vim.lsp.enable("css_modules_ls")
        vim.lsp.enable("css_variables_ls")
        vim.lsp.enable("tailwindcss_ls")
        vim.lsp.enable("marksman_ls")
        vim.lsp.enable("json_ls")
        vim.lsp.enable("sql_ls")
        vim.lsp.enable("yaml_ls")
        vim.lsp.enable("go_ls")
        vim.lsp.enable("golangci_lint_ls")
        -- config.omnisharp.setup(cs_setup(on_attach, capabilities, config.util, cs_extensions))
        vim.lsp.enable("csharp_ls")
        cs_extensions.buf_read_cmd_bind()
        config.hyprls.setup(default_setup(on_attach, capabilities))

        vim.diagnostic.config({ virtual_text = true })
    end,
}
