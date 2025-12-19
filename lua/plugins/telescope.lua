local M = { 'nvim-telescope/telescope.nvim' }
M.custom = {}

function M.custom.change_neovide_font()
    if vim.g.neovide == nil then
        print 'Nerd font only posible to change on neovide for now'
        return true
    end

    local fonts = {}
    -- LEE LAS FUENTES INSTALADAS
    -- for font in io.popen('fc-list : family | sort | uniq'):lines() do
    --     table.insert(fonts, font)
    -- end
    -- NUEVA VERSION MAS LIMPIA
    for font in io.popen("fc-list : family | cut -d',' -f1 | sort -u"):lines() do
        table.insert(fonts, font)
    end

    local pickers = require 'telescope.pickers'
    local finders = require 'telescope.finders'
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'
    local conf = require('telescope.config').values

    pickers
        .new({}, {
            prompt_title = 'Select Neovide Font',
            finder = finders.new_table {
                results = fonts,
            },
            sorter = conf.generic_sorter {},
            attach_mappings = function(buff, _)
                actions.select_default:replace(function()
                    actions.close(buff)
                    local selection = action_state.get_selected_entry()
                    -- CAMBIA LA FUENTE DE NEOVIDE DINÁMICAMENTE
                    vim.o.guifont = selection[1] .. ':h8'
                    print('Neovide font set to: ' .. selection[1])
                end)
                return true
            end,
        })
        :find()
end

function M.custom.list_plugins()
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'

    builtin.find_files {
        prompt_title = 'Plugins',
        cwd = vim.fn.stdpath 'config' .. '/lua/plugins',
        attach_mappings = function(_, map)
            map('i', '<c-y>', function(prompt_bufnr)
                local new_plugin = action_state.get_current_line()
                actions.close(prompt_bufnr)
                vim.cmd(string.format('edit ~/.config/nvim/lua/plugins/%s.lua', new_plugin))
            end)
            return true
        end,
    }
end

function M.custom.list_buffers()
    local telescope = require 'telescope'
    telescope.extensions.file_browser.file_browser {
        path = '%:h:p',
        select_buffer = true,
    }
end

function M.custom.grep_string()
    local builtin = require 'telescope.builtin'
    builtin.grep_string {
        use_regex = true,
        word_match = '-w',
    }
end

function M.custom.colorscheme()
    local builtin = require 'telescope.builtin'
    local bg_util = require 'utils.bg_color_setuper'

    builtin.colorscheme()
    vim.api.nvim_create_autocmd('ColorScheme', {
        once = true, -- solo una vez tras escoger el nuevo esquema
        callback = function()
            bg_util:clear_cache()
            bg_util:bg_setuper(false, true)
        end,
    })
end

M.lazy = false
M.dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
}

M.opts = {
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
}

M.config = function(opts)
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local mapper = vim.keymap
    opts = opts or {}
    telescope.setup(opts)

    -- BUILTIN
    mapper.set('n', '<space>cb', builtin.buffers, { desc = 'Telescope= buffers' })
    mapper.set('n', '<space>gs', builtin.git_status, { desc = 'Telescope= Git status' })
    mapper.set('n', '<space>gf', builtin.git_files, { desc = 'Telescope= Git Files' })
    mapper.set('n', '<space>gc', builtin.git_commits, { desc = 'Telescope= Git commits' })
    mapper.set('n', '<space>gb', builtin.git_branches, { desc = 'Telescope= Git branches' })
    mapper.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope= Find Files' })
    mapper.set('n', '<space>h', builtin.help_tags, { desc = 'Telescope= Help' })
    mapper.set('n', '<space>hk', builtin.keymaps, { desc = 'Telescope= keymaps' })
    mapper.set('n', '<space>lg', builtin.live_grep, { desc = 'Telescope= live grep' })
    -- CUSTOM
    mapper.set('n', '<space>cc', M.custom.colorscheme, { desc = 'Change colorscheme' })
    mapper.set('n', '<space>LG', M.custom.grep_string, { desc = 'Custom grep string' })
    mapper.set('n', '<space>pp', M.custom.list_plugins, { desc = 'Plugins installed' })
    mapper.set('n', '<space>fb', M.custom.list_buffers, { desc = 'Current folder file browser' })
    mapper.set('n', '<space>nf', M.custom.change_neovide_font, { desc = 'Change neovide fonts' })
end

return M
