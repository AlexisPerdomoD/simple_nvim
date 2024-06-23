return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    priority = 10000,
    config = function()
        require("neo-tree").setup({
             window = {
                 position = "float",

                 --width = 30,
                 mapping_options = {
                     noremap = true,
                     -- nowait = true,
                 },
             },
            close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
            popup_border_style = "rounded",
            enable_git_status = false,
            enable_diagnostics = true,
            -- open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
            -- sort_case_insensitive = false,                                     -- used when sorting files and directories in the tree
            --  sort_function = nil,                                           -- use a custom function for sorting files and directories in the tree
            -- sort_function = function(a, b)
            --     if a.type == b.type then
            --         return a.path > b.path
            --     else
            --         return a.type > b.type
            --     end
            -- end,    -- this sorts files and directories descendantly
            default_component_configs = {
                -- container = {
                --     enable_character_fade = true
                -- },
                indent = {
                    indent_size = 2,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = false,
                    -- indent_marker = "│",
                    -- last_indent_marker = "└",
                    -- highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added     = "+", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted   = "✖", -- this can only be used in the git_status source
                        renamed   = "󰁕", -- this can only be used in the git_status source
                        -- Status type
                        untracked = "??",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    }
                },
                -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                file_size = {
                    enabled = true,
                    required_width = 120, -- min width of window required to show this column
                },
                type = {
                    enabled = false,
                    required_width = 120, -- min width of window required to show this column
                },
                last_modified = {
                    enabled = true,
                    required_width = 120, -- min width of window required to show this column
                },
                created = {
                    enabled = false,
                    required_width = 200, -- min width of window required to show this column
                },
                symlink_target = {
                    enabled = false,
                },
            },
            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_by_name = {
                        ".DS_Store",
                        "thumbs.db",
                        "node_modules",
                        ".git",
                    },
                    always_show_by_pattern = { -- uses glob style patterns
                        ".env*",
                    },
                },
            },

        })
        

        vim.keymap.set("n", "<space>.", "<cmd>Neotree toggle reveal current<cr>")
        vim.keymap.set("n", "<space>d", "<cmd>Neotree toggle reveal left<cr>")
        -- git status
        vim.keymap.set("n", ".gs", "<cmd>Neotree float toggle git_status<cr>")
    end,
}
