local M        = { 'rmagatti/auto-session' }
M.dependencies = { 'nvim-telescope/telescope.nvim' }

M.lazy         = false

M.keys         = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { '<space>s',  '<cmd>AutoSession search<CR>', desc = 'Session search' },
    { '<space>S',  '<cmd>AutoSession save<CR>',   desc = 'Save session' },
    { '<space>ws', '<cmd>AutoSession toggle<CR>', desc = 'Toggle autosave' },
}

---@module "auto-session"
---@type AutoSession.Config
M.opts         = {
    -- allowed_dirs = {
    --     '~/work/*',
    -- },
    suppressed_dirs = {
        '~/work',
        '~/.config/*',
    },
    lazy_support = true,
    auto_restore = true,
    auto_save = true,
    -- The following are already the default values, no need to provide them if these are already the settings you want.
    session_lens = {
        mappings = {
            -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
            delete_session = { 'i', '<C-D>' },
            alternate_session = { 'i', '<C-S>' },
            copy_session = { 'i', '<C-Y>' },
        },

        picker_opts = {
            telescope = {


            }
            -- For Telescope, you can set theme options here, see:
            -- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
            -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua
            --
            -- border = true,
            -- layout_config = {
            --   width = 0.8, -- Can set width and height as percent of window
            --   height = 0.5,
            -- },

            -- For Snacks, you can set layout options here, see:
            -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-layouts
            --
            -- preset = "dropdown",
            -- preview = false,
            -- layout = {
            --   width = 0.4,
            --   height = 0.4,
            -- },
        },

        load_on_setup = true,
    },
}



return M
