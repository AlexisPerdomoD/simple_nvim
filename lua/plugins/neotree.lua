return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
        'lewis6991/gitsigns.nvim',
        -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    priority = 900,
    config = function()
        local nt = require 'neo-tree'
        nt.setup {
            auto_clean_after_session_restore = true,
            enable_refresh_on_write = true,
            add_blank_line_at_top = true,
            close_if_last_window = true,
            popup_border_style = 'rounded',
            enable_git_status = true,
            enable_diagnostics = true,
            enable_cursor_hijack = false,

            buffers = {
                window = {
                    width = 40,
                    auto_expand_width = true,
                },
            },

            window = {
                width = 40,
                position = 'left',
                auto_expand_width = true,
                mapping_options = {
                    noremap = true,
                    -- nowait = true,
                },
            },

            default_component_configs = {
                container = {
                    enable_character_fade = true,
                    right_padding = 0,
                },

                indent = {
                    indent_size = 1,
                    padding = 0, -- extra padding on left hand side
                    with_markers = false,
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = '',
                    expander_expanded = '',
                    expander_highlight = 'NeoTreeExpander',
                },

                icon = {
                    folder_empty_open = '󰜌',
                    -- folder_closed = '',
                    folder_closed = '',
                    -- folder_open = '',
                    folder_open = '',
                    folder_empty = '󰜌',
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = '*',
                    highlight = 'NeoTreeFileIcon',
                    use_filtered_colors = true,
                    provider = nil,
                },

                modified = {
                    symbol = '[+]',
                    highlight = 'NeoTreeModified',
                },

                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = 'NeoTreeFileName',
                },

                git_status = {
                    symbols = {
                        -- Change type
                        added = '+', -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted = '✖', -- this can only be used in the git_status source
                        renamed = '󰁕', -- this can only be used in the git_status source
                        -- Status type
                        untracked = '??',
                        ignored = '',
                        unstaged = '󰄱',
                        staged = '',
                        conflict = '',
                    },
                },

                last_modified = {
                    format = 'relative',
                    enabled = true,
                    required_width = 40, -- min width of window required to show this column
                },

                -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                file_size = {
                    enabled = true,
                    required_width = 120, -- min width of window required to show this column
                },

                type = {
                    enabled = true,
                    required_width = 120, -- min width of window required to show this column
                },

                created = {
                    format = 'relative',
                    enabled = false,
                    required_width = 200, -- min width of window required to show this column
                },

                symlink_target = {
                    enabled = true,
                },
            },

            filesystem = {

                follow_current_file = {
                    enabled = true,
                },

                filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_by_name = {
                        '.DS_Store',
                        'thumbs.db',
                        'node_modules',
                        '.git',
                    },

                    always_show_by_pattern = { -- uses glob style patterns
                        '.env*',
                        '.prettierrc',
                        '.eslintrc',
                        '.gitignore',
                        '.zshrc',
                    },
                },
            },
        }

        local neotree_cmd = require 'neo-tree.command'

        vim.keymap.set('n', '<space><leader>', function()
            neotree_cmd.execute { toggle = true, dir = vim.fn.getcwd() }
        end)

        vim.keymap.set('n', '<space><space>', function()
            neotree_cmd.execute { toggle = true, position = 'left' }
        end)

        vim.keymap.set('n', '<leader>gs', function()
            neotree_cmd.execute { source = 'git_status', toggle = true, position = 'float' }
        end)

        vim.keymap.set('n', '<space>b', function()
            neotree_cmd.execute { source = 'buffers', toggle = true, position = 'float' }
        end)

        -- LEGACY
        -- vim.keymap.set('n', '<space><leader>', '<cmd>Neotree float toggle  current<cr>')
        -- vim.keymap.set('n', '<space><space>', '<cmd>Neotree toggle  left<cr>')
        -- vim.keymap.set('n', '<leader>gs', '<cmd>Neotree float toggle git_status<cr>')
        -- vim.keymap.set('n', '<space>b', '<cmd>Neotree float  toggle buffers<cr>')
    end,
}
