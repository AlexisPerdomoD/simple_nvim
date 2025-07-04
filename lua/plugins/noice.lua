return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp",
        "rcarriga/nvim-notify",
    },
    config = function()
        local rounded_border_style = {
            top_left = "╭",
            top = "─",
            top_right = "╮",
            left = "│",
            right = "│",
            bottom_left = "╰",
            bottom = "─",
            bottom_right = "╯",
        }
        require("noice").setup({
            cmdline = {

                enabled = true, -- enables the Noice cmdline UI
                view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
                spell = false,
                views = {
                    ["^z="] = "cmdline",
                },
                opts = {}, -- global options for the cmdline. See section on views
                ---@type table<string, CmdlineFormat>
                format = {
                    cmdline = { pattern = "^:", icon = "", lang = "vim", title = "PODER" },
                    search_down = {
                        kind = "search",
                        pattern = "^/",
                        icon = "  ",
                        lang = "regex",
                        title = " Search Down ",
                    },
                    search_up = {
                        kind = "search",
                        pattern = "^%?",
                        icon = "  ",
                        lang = "regex",
                        title = " Search Up ",
                    },
                    filter = { pattern = "^:%s*!", icon = "  ", lang = "bash", title = "Filter" },
                    lua = {
                        pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
                        icon = "  ",
                        lang = "lua",
                        title = " Lua ",
                    },
                    help = { pattern = "^:%s*he?l?p?%s+", icon = " ", title = " Help " },
                    input = {}, -- Used by input()
                },
            },
            messages = {
                enabled = true, -- enables the Noice messages UI
                view = "mini", -- default view for messages
                view_error = "notify", -- view for errors
                view_warn = "notify", -- view for warnings
                view_history = "messages", -- view for :messages
                -- view_search = false,
                view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
            },
            popupmenu = {
                enabled = false, -- enables the Noice popupmenu UI
                ---@type 'nui'|'cmp'
                backend = "cmp", -- backend to use to show regular cmdline completions
                ---@type NoicePopupmenuItemKind|false
                -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
                kind_icons = {}, -- set to `false` to disable icons
            },
            -- default options for require('noice').redirect
            -- see the section on Command Redirection
            ---@type NoiceRouteConfig
            redirect = {
                view = "popup",
                filter = { event = "msg_show" },
            },
            -- You can add any custom commands below that will be available with `:Noice command`
            ---@type table<string, NoiceCommand>
            commands = {
                history = {
                    -- options for the message history that you get with `:Noice`
                    view = "split",
                    opts = { enter = true, format = "details" },
                    filter = {
                        any = {
                            { event = "notify" },
                            { error = true },
                            { warning = true },
                            { event = "msg_show", kind = { "" } },
                            { event = "lsp", kind = "message" },
                        },
                    },
                },
                -- :Noice last
                last = {
                    view = "mini",
                    opts = { enter = true, format = "details" },
                    filter = {
                        any = {
                            { event = "notify" },
                            { error = true },
                            { warning = true },
                            { event = "msg_show", kind = { "" } },
                            { event = "lsp", kind = "message" },
                        },
                    },
                    filter_opts = { count = 1 },
                },
                -- :Noice errors
                errors = {
                    -- options for the message history that you get with `:Noice`
                    view = "mini",
                    opts = { enter = true, format = "details" },
                    filter = { error = true },
                    filter_opts = { reverse = true },
                },
            },
            notify = {
                enabled = true,
                view = "mini",
                background_colour = "#000000",
            },
            lsp = {
                progress = {
                    enabled = true,
                    --- @type NoiceFormat|string
                    format = "lsp_progress",
                    --- @type NoiceFormat|string
                    format_done = "lsp_progress_done",
                    throttle = 1000 / 30, -- frequency to update lsp progress message
                    view = "mini",
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = {
                    enabled = true,
                    view = nil, -- when nil, use defaults from documentation
                    ---@type NoiceViewOptions
                    opts = {}, -- merged with defaults from documentation
                },
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = true,
                        trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                        luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                        throttle = 50, -- Debounce lsp signature help request by 50ms
                    },
                    view = nil, -- when nil, use defaults from documentation
                    ---@type NoiceViewOptions
                    opts = {}, -- merged with defaults from documentation
                },
                message = {
                    -- Messages shown by lsp servers
                    enabled = true,
                    view = "mini",
                    opts = {},
                },
                -- defaults for hover and signature help
                documentation = {
                    view = "hover",
                    ---@type NoiceViewOptions
                    opts = {
                        lang = "markdown",
                        replace = true,
                        render = "plain",
                        format = { "{message}" },
                        win_options = { concealcursor = "n", conceallevel = 3 },
                    },
                },
            },
            markdown = {
                hover = {
                    ["|(%S-)|"] = vim.cmd.help, -- vim help links
                    ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
                },
                highlights = {
                    ["|%S-|"] = "@text.reference",
                    ["@%S+"] = "@parameter",
                    ["^%s*(Parameters:)"] = "@text.title",
                    ["^%s*(Return:)"] = "@text.title",
                    ["^%s*(See also:)"] = "@text.title",
                    ["{%S-}"] = "@parameter",
                },
            },
            health = {
                checker = true, -- Disable if you don't want health checks to run
            },
            smart_move = {
                -- noice tries to move out of the way of existing floating windows.
                enabled = true, -- you can disable this behaviour here
                -- add any filetypes here, that shouldn't trigger smart move.
                excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
            },
            ---@type NoicePresets
            presets = {
                bottom_search = false, -- use a classic bottom cmdline for search
                command_palette = false, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
            throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
            ---@type NoiceConfigViews
            views = {
                cmdline_popup = {
                    position = {
                        row = "50%",
                        col = "50%",
                    },
                    size = {
                        width = "30%",
                        height = "auto",
                    },
                    border = {
                        style = rounded_border_style,
                        -- style = "none",
                        padding = { 0, 0 },
                    },
                    filter_options = {},
                    win_options = {
                        winhighlight = {
                            Normal = "TelescopePromptNormal",
                            FloatBorder = "DiagnosticInfo",
                        },
                    },
                },
                split = {
                    enter = true,
                },
                notify = {
                    size = {
                        width = 30,
                    },
                },
                mini = {
                    position = {
                        row = "5%",
                        col = "50%",
                    },
                    win_options = {
                        winblend = 0,
                        -- winhighlight = {}
                    },
                    border = {
                        style = rounded_border_style,
                        padding = { 0, 1 },
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 4,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = rounded_border_style,
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = "TelescopePromptNormal",
                            FloatBorder = "DiagnosticInfo",
                        },
                    },
                },
            }, ---@see section on views
            ---@type NoiceRouteConfig[]
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "search_count",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "notify",
                        kind = "info",
                        find = "No information available",
                    },
                    opts = { skip = true },
                },
            },
        })
    end,
}
