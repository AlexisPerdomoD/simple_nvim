return {
    -- THEMES
    require 'config.themes',

    -- ADDS SUPPORT TO LUA INTO NVIM
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                -- { path = '${3rd}/vim/library', word = 'vim%.fn' },
            },
        },
    },

    -- ADDS SUPPORT TO CLOSE TAGS IN HTML
    {
        'windwp/nvim-ts-autotag',
        ft = { 'html', 'jsx', 'tsx' },
        config = function()
            local autotag = require 'nvim-ts-autotag'
            autotag.setup {
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = true, -- Auto close on trailing </
                },
            }
        end,
    },

    -- ADDS SUPPORT TO AUTOPAIRS IN INSERT MODE
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },

    -- JAVA LSP AUTOCOMAND SPECIFIC CONFIGURATION
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
        config = function()
            -- JAVA LSP AUTOCOMAND SPECIFIC CONFIGURATION
            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'java',
                callback = function(_)
                    local jdtls = require 'jdtls'
                    local lang_setup = require 'config.plugin.jdtls'
                    local cfg = lang_setup:get_config()
                    jdtls.start_or_attach(cfg)
                end,
            })
        end,
    },

    -- USEFUL TOGGLETERM CONFIGURATION
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            local p = require 'toggleterm'
            p.setup {
                size = function(term)
                    if term.direction == 'horizontal' then
                        return 15
                    elseif term.direction == 'vertical' then
                        return vim.o.columns * 0.4
                    else
                        return 20
                    end
                end,
                open_mapping = [[<c-.>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
                -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
                -- on_open = fun(t: Terminal), -- function to run when the terminal opens
                -- on_close = fun(t: Terminal), -- function to run when the terminal closes
                -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
                -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
                -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
                hide_numbers = true, -- hide the number column in toggleterm buffers
                shade_filetypes = {},
                -- autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
                -- highlights = {
                --   -- highlights which map to a highlight group name and a table of it's values
                --   -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
                --   Normal = {
                --     guibg = "<VALUE-HERE>",
                --   },
                --   NormalFloat = {
                --     link = 'Normal'
                --   },
                --   FloatBorder = {
                --     guifg = "<VALUE-HERE>",
                --     guibg = "<VALUE-HERE>",
                --   },
                -- },
                shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
                shading_factor = '3', -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
                start_in_insert = true,
                insert_mappings = true, -- whether or not the open mapping applies in insert mode
                terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                persist_size = true,
                persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
                direction = 'float', -- 'vertical' | 'horizontal' | 'tab' | 'float',
                close_on_exit = true, -- close the terinal window when the process exits
                -- Change the default shell. Can be a string or a function returning a string
                shell = vim.o.shell,
                auto_scroll = true, -- automatically scroll to the bottom on terminal output
                -- This field is only relevant if direction is set to 'float'
                float_opts = {
                    -- The border key is *almost* the same as 'nvim_open_win'
                    -- see :h nvim_open_win for details on borders however
                    -- the 'curved' border is a custom border type
                    -- not natively supported but implemented in this plugin.
                    border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
                    -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
                    --  width = 100,
                    --  height = vim.o.columns * 0.5,
                    --  row = 2,
                    --  col = vim.o.columns * 0.3,
                    --  winblend = 3,
                    --  zindex = <value>,
                    title_pos = 'center', -- 'left' | 'center' | 'right', position of the title of the floating window
                },
                -- winbar = {
                --   enabled = false,
                --   name_formatter = function(term) --  term: Terminal
                --     return term.name
                --   end
                -- },
            }
        end,
    },
}
