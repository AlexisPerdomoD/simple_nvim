--- reference callback default
--- this is the suggested way to implement lsp as vanilla nvim without lspsaga, conform etc. at this point for me is ok just to remove lspconfig and adapt my own config
-- function callback(args)
--     local bufnr = args.buf
--     local opts = { buffer = bufnr, noremap = true, silent = true }
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     if client:supports_method("textDocument/implementation") then
--         -- Create a keymap for vim.lsp.buf.implementation ...
--     end
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method("textDocument/completion") then
--         -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--         -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--         -- client.server_capabilities.completionProvider.triggerCharacters = chars
--         -- default way pero ya lo habiamos implementado con los keys de autocompletion y lspsaga
--         -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--     end
--     -- Auto-format ("lint") on save.
--     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--     if
--         not client:supports_method("textDocument/willSaveWaitUntil")
--         and client:supports_method("textDocument/formatting")
--     then
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
--             buffer = args.buf,
--             callback = function()
--                 vim.lsp.buf.format({
--                     bufnr = args.buf,
--                     id = client.id,
--                     timeout_ms = 1000,
--                 })
--             end,
--         })
--     end
-- end

return {
    "nvimdev/lspsaga.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "decodetalkers/csharpls-extended-lsp.nvim",
        "hrsh7th/cmp-nvim-lsp",
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

        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            ),
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my.lsp", {}),
            callback = function(args)
                local bufnr = args.buf
                local opts = { buffer = bufnr, noremap = true, silent = true }

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
                vim.keymap.set("n", "..", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

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
            end,
        })

        local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
        for _, file in ipairs(vim.fn.readdir(lsp_dir)) do
            if file:match("%.lua$") then
                local server_name = file:gsub("%.lua$", "")
                vim.lsp.enable(server_name)
            end
        end
        vim.diagnostic.config({ virtual_text = true })
    end,
}
