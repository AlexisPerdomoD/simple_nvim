-- Configuración completa de avante.nvim con lazy.nvim
return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        -- event = "InsertEnter",
        lazy = true,
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },

    -- Integración con nvim-cmp (opcional)
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function() require("copilot_cmp").setup() end,
    },

    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = true,
        version = false, -- Never set this value to "*"! Never!
        opts = {
            provider = "copilot",
            copilot = {
                endpoint = "https://api.githubcopilot.com",
                model = "claude-3.5-sonnet",
                proxy = nil, -- [protocol://]host[:port] Use this proxy
                allow_insecure = false, -- Allow insecure server connections
                timeout = 30000, -- Timeout in milliseconds
                temperature = 0.75,
                max_tokens = 20480,
            },
            mappings = {
                ---@class AvanteConflictMappings
                diff = {
                    ours = "co",
                    theirs = "ct",
                    all_theirs = "ca",
                    both = "cb",
                    cursor = "cc",
                    next = "]x",
                    prev = "[x",
                },
                suggestion = {
                    accept = "<M-l>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
                jump = {
                    next = "]]",
                    prev = "[[",
                },
                submit = {
                    normal = "<CR>",
                    insert = "<C-a>",
                },
                cancel = {
                    normal = { "<C-c>", "<Esc>", "q" },
                    insert = { "<C-c>" },
                },
                -- NOTE: The following will be safely set by avante.nvim
                ask = "<space>aa",
                new_ask = "<space>an",
                edit = "<space>ae",
                refresh = "<space>ar",
                focus = "<space>af",
                stop = "<space>aS",
                toggle = {
                    default = "<space>at",
                    debug = "<space>ad",
                    hint = "<space>ah",
                    suggestion = "<space>as",
                    repomap = "<space>aR",
                },
                sidebar = {
                    apply_all = "A",
                    apply_cursor = "a",
                    retry_user_request = "r",
                    edit_user_request = "e",
                    switch_windows = "<Tab>",
                    reverse_switch_windows = "<S-Tab>",
                    remove_file = "d",
                    add_file = "@",
                    close = { "q" },
                    ---@alias AvanteCloseFromInput { normal: string | nil, insert: string | nil }
                    ---@type AvanteCloseFromInput | nil
                    close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
                },
                files = {
                    add_current = "<space>ac", -- Add current buffer to selected files
                    add_all_buffers = "<space>aB", -- Add all buffer files to selected files
                },
                select_model = "<space>a?", -- Select model command
                select_history = "<space>ah", -- Select history command
            },
            windows = {
                ---@alias AvantePosition "right" | "left" | "top" | "bottom" | "smart"
                position = "left",
                fillchars = "eob: ",
                wrap = true, -- similar to vim.o.wrap
                width = 30, -- default % based on available width in vertical layout
                height = 30, -- default % based on available height in horizontal layout
                sidebar_header = {
                    enabled = true, -- true, false to enable/disable the header
                    align = "left", -- left, center, right for title
                    rounded = false,
                },
                input = {
                    prefix = "> ",
                    height = 8, -- Height of the input window in vertical layout
                },
                edit = {
                    border = { " ", " ", " ", " ", " ", " ", " ", " " },
                    start_insert = true, -- Start insert mode when opening the edit window
                },
                ask = {
                    floating = true, -- Open the 'AvanteAsk' prompt in a floating window
                    border = { " ", " ", " ", " ", " ", " ", " ", " " },
                    start_insert = false, -- Start insert mode when opening the ask window
                    ---@alias AvanteInitialDiff "ours" | "theirs"
                    focus_on_apply = "ours", -- which diff to focus after applying
                },
            },
            --- @class AvanteConflictConfig
            diff = {
                autojump = true,
                --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
                --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
                --- Disable by setting to -1.
                override_timeoutlen = 500,
            },
            --- @class AvanteHintsConfig
            hints = {
                enabled = true,
            },
            --- @class AvanteRepoMapConfig
            repo_map = {
                ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules" }, -- ignore files matching these
                negate_patterns = {}, -- negate ignore files matching these.
            },
            --- @class AvanteFileSelectorConfig
            file_selector = {
                provider = nil,
                -- Options override for custom providers
                provider_opts = {},
            },
            selector = {
                ---@alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
                provider = "telescope",
                provider_opts = {},
                exclude_auto_select = {}, -- List of items to exclude from auto selection
            },
            suggestion = {
                debounce = 600,
                throttle = 600,
            },
            disabled_tools = {}, ---@type string[]
            ---@type AvanteLLMToolPublic[] | fun(): AvanteLLMToolPublic[]
            custom_tools = {},
            ---@type AvanteSlashCommand[]
            slash_commands = {},
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
}
