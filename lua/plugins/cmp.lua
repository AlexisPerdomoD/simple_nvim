return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-git",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "windwp/nvim-autopairs",
        --devi icons
        "ryanoasis/vim-devicons",
    },
    event = "VeryLazy",
    config = function()
        ---@diagnostic disable: missing-fields
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        cmp.setup({
            sources = {
                {
                    name = "nvim_lsp",
                    max_item_count = 30,
                },
                { name = "path" },
                { name = "luasnip" },
                { name = "buffer" },
            },
            -- performance = {
            --     trigger_debounce_time = 500,
            --     throttle = 550,
            --     fetching_timeout = 80,
            -- },
            formatting = {

                format = function(_, vim_item)
                    local KIND_ICONS = {
                        Text = " ", -- Texto
                        Method = " ", -- Método
                        Function = " ", -- Función
                        Constructor = " ", -- Constructor
                        Field = " ", -- Campo
                        Variable = " ", -- Variable
                        Class = " ", -- Clase
                        Interface = " ", -- Interfaz
                        Module = " ", -- Módulo
                        Property = " ", -- Propiedad
                        Unit = " ", -- Unidad
                        Value = " ", -- Valor
                        Enum = " ", -- Enumeración
                        Keyword = " ", -- Palabra clave
                        Snippet = " ", -- Fragmento
                        Color = " ", -- Color
                        File = " ", -- Archivo
                        Reference = " ", -- Referencia
                        Folder = " ", -- Carpeta
                        EnumMember = " ", -- Miembro de enumeración
                        Constant = " ", -- Constante
                        Struct = " ", -- Estructura
                        Event = " ", -- Evento
                        Operator = " ", -- Operador
                        TypeParameter = " ", -- Parámetro de tipo
                    }
                    vim_item.kind = KIND_ICONS[vim_item.kind] or vim_item.kind

                    return vim_item
                end,
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-x>"] = cmp.mapping.abort(),
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.choice_active() then
                        luasnip.change_choice(1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-Down>"] = cmp.mapping.select_next_item(),
                ["<C-Up>"] = cmp.mapping.select_prev_item(),
                ["<C-Right>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
                ["<c-space>"] = cmp.mapping.complete(),
            },
        })
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

        -- Set configuration for specific filetype.
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
                { name = "buffer" },
            }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })
        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end,
}
