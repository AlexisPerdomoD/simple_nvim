---@diagnostic disable: missing-fields
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local M = {}
function M.setup()
    cmp.setup({
        -- Configuración de los colores
        -- vim.cmd([[
        --      highlight! Pmenu guibg=NONE ctermbg=NONE
        --      highlight! PmenuSel guibg=NONE guifg=NONE
        --      highlight! CmpBorder guifg=NONE guibg=NONE
        --      highlight! CmpDocBorder guifg=NONE guibg=NONE
        --  ]]),
        -- vim.cmd([[
        --     highlight! CmpBorder guifg=#3E4452
        --     highlight! CmpDocBorder guifg=#3E4452
        --     highlight! CmpPmenu guibg=#1E222A
        --     highlight! CmpDoc guibg=#1E222A
        -- ]]),
        --
        window = {
            completion = {

                border = 'shadow', -- Opciones: 'single', double', 'rounded', 'solid', 'shadow', o { 'top', 'right', 'bottom', 'left' }
                winhighlight = 'Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None',
                scrollbar = true,
            },
            documentation = {
                border = 'solid',
                winhighlight = 'Normal:Pmenu,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None',
                scrollbar = true,
            },
        },

        formatting = {
            format = function(entry, vim_item)
                local KIND_ICONS = {
                    Tailwind = '󰹞󰹞󰹞',
                    Text = ' ', -- Texto
                    Method = ' ', -- Método
                    Function = ' ', -- Función
                    Constructor = ' ', -- Constructor
                    Field = ' ', -- Campo
                    Variable = ' ', -- Variable
                    Class = ' ', -- Clase
                    Interface = ' ', -- Interfaz
                    Module = ' ', -- Módulo
                    Property = ' ', -- Propiedad
                    Unit = ' ', -- Unidad
                    Value = ' ', -- Valor
                    Enum = ' ', -- Enumeración
                    Keyword = ' ', -- Palabra clave
                    Snippet = ' ', -- Fragmento
                    Color = ' ', -- Color
                    File = ' ', -- Archivo
                    Reference = ' ', -- Referencia
                    Folder = ' ', -- Carpeta
                    EnumMember = ' ', -- Miembro de enumeración
                    Constant = ' ', -- Constante
                    Struct = ' ', -- Estructura
                    Event = ' ', -- Evento
                    Operator = ' ', -- Operador
                    TypeParameter = ' ', -- Parámetro de tipo
                }

                if vim_item.kind == 'Color' and entry.completion_item.documentation then
                    local _, _, r, g, b =
                    ---@diagnostic disable-next-line: param-type-mismatch
                        string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')

                    if r and g and b then
                        local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
                        local group = 'Tw_' .. color

                        if vim.api.nvim_call_function('hlID', { group }) < 1 then
                            vim.api.nvim_command('highlight' .. ' ' .. group .. ' ' .. 'guifg=#' .. color)
                        end

                        vim_item.kind = KIND_ICONS.Tailwind
                        vim_item.kind_hl_group = group

                        return vim_item
                    end
                end

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
            ["<C-Right>"] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            ["<c-space>"] = cmp.mapping.complete(),
        },
        sources = {
            {
                name = "nvim_lsp",
                -- priority = 10,
                -- keyword_length = 6,
                -- group_index = 1,
                max_item_count = 30,
            },
            -- { name = "path" },
            { name = "luasnip" },
            { name = "buffer" },
        },
        -- performance = {
        --     trigger_debounce_time = 500,
        --     throttle = 550,
        --     fetching_timeout = 80,
        -- },
    })
    -- highlight PmenuSel guibg=#333333 guifg=#FFFFFF gui=bold
     vim.cmd [[
             highlight Pmenu guibg=NONE ctermbg=NONE
    
             highlight PmenuSbar guibg=NONE
             highlight PmenuThumb guibg=NONE
       ]]
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })
end

return M
