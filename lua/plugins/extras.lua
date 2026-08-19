return {
    -- THEMES
    require 'config.themes',

    -- ADDS SUPPORT TO LUA INTO NVIM
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        -- lazy = true,
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

    -- ADDS SUPPORT TO LUASNIP
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        event = 'VeryLazy',
        version = 'v2.*',
        dependencies = { 'rafamadriz/friendly-snippets' },
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
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    local cfg = lang_setup:get_config(capabilities)
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

    -- ADDS SUPPORT TO HARPOON
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        -- event = 'VeryLazy',
        lazy = true,
        config = function()
            local harpoon = require 'harpoon'

            -- REQUIRED
            harpoon:setup()
            -- REQUIRED

            vim.keymap.set('n', '<space>a', function()
                harpoon:list():add()
                local filename = vim.fn.expand '%:t' -- o usa vim.fn.expand("%:t") solo para el nombre
                vim.notify(
                    'Archivo agregado a Harpoon: ' .. filename,
                    vim.log.levels.INFO,
                    { title = 'Harpoon', filename = filename }
                )
            end)
            vim.keymap.set('n', '<space>e', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = 'Harpoon = mostrar menú rápido' })

            vim.keymap.set('n', '<space>1', function()
                harpoon:list():select(1)
            end, { desc = 'Harpoon = seleccionar elemento 1' })
            vim.keymap.set('n', '<space>2', function()
                harpoon:list():select(2)
            end, { desc = 'Harpoon = seleccionar elemento 2' })
            vim.keymap.set('n', '<space>3', function()
                harpoon:list():select(3)
            end, { desc = 'Harpoon = seleccionar elemento 3' })
            vim.keymap.set('n', '<space>4', function()
                harpoon:list():select(4)
            end, { desc = 'Harpoon = seleccionar elemento 4' })

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set('n', '<space>|', function()
                harpoon:list():prev()
            end, { desc = 'Harpoon = prev' })
            vim.keymap.set('n', '<space>\\', function()
                harpoon:list():next()
            end, { desc = 'Harpoon = next' })
        end,
    },

    -- ADDS SUPPORT TO MARKDOWN PREVIEW
    {
        'selimacerbas/markdown-preview.nvim',
        dependencies = { 'selimacerbas/live-server.nvim' },
        -- event = 'VeryLazy',
        ft = 'markdown',
        config = function()
            local mp = require 'markdown_preview'
            mp.setup {
                instance_mode = 'takeover', -- "takeover" or "multi" (see below)
                port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
                host = '127.0.0.1', -- bind address; "0.0.0.0" for network access (see Remote access)
                open_browser = true, -- auto-open browser on start

                -- nil = system default browser
                -- string = browser name ("Firefox") or binary ("google-chrome")
                -- table = full command, URL appended ({ "google-chrome", "--incognito" })
                -- On macOS, string values are passed via `open -a <name>`.
                browser = nil,

                content_name = 'content.md', -- workspace content file
                index_name = 'index.html', -- workspace HTML file
                custom_css = '', -- CSS file layered over bundled styles (~ and $VARS ok; "" = off)
                workspace_dir = nil, -- nil = auto (shared for takeover, per-buffer for multi)

                overwrite_index_on_start = true, -- copy plugin's index.html on every start

                auto_refresh = true, -- auto-update on buffer changes
                auto_refresh_events = { -- which events trigger refresh
                    'InsertLeave',
                    'TextChanged',
                    'TextChangedI',
                    'BufWritePost',
                },
                debounce_ms = 300, -- debounce interval
                notify_on_refresh = false, -- show notification on refresh

                mermaid_renderer = 'rust', -- "js" (browser mermaid.js) or "rust" (mmdr CLI, ~400x faster)

                default_theme = 'dark', -- "dark" or "light"; initial preview theme (toggleable in browser)

                yaml_mode = 'panel', -- front matter: "panel" (collapsible above preview), "hide", or "raw"

                allow_raw_html = true, -- render raw HTML in markdown; set false for untrusted files (see Security)

                scroll_sync = true, -- browser follows cursor position

                -- Fraction (0–1): vertical position of the final line when scrolled to end.
                -- 0.5 = middle of viewport (default), 1.0 = bottom edge (no extra space)
                bottom_padding = 0.5,

                hooks = {
                    on_start = nil, -- fun(url: string)|nil — called after preview starts
                    on_stop = nil, -- fun()|nil — called after preview stops
                },
            }
        end,
    },
}
