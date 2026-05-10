local M = { 'nvim-telescope/telescope.nvim' }
M.custom = {}

function M.custom.change_neovide_font()
    if vim.g.neovide == nil then
        vim.notify 'Nerd font only posible to change on neovide for now'
        return true
    end

    local fonts = {}
    for line in io.popen("fc-list :spacing=mono family | cut -d',' -f1 | sort -u"):lines() do
        local family = line:match '^([^,]+)'
        if family and family ~= '' then
            fonts[#fonts + 1] = family
        end
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
            attach_mappings = function(bufnr, _)
                local picker = action_state.get_current_picker(bufnr)

                -- cache original set_selection
                local original_set_selection = picker.set_selection

                -- override selection change (REAL hook point)
                picker.set_selection = function(self, row)
                    original_set_selection(self, row)

                    local entry = action_state.get_selected_entry()
                    if entry and entry[1] then
                        vim.o.guifont = entry[1]
                    end
                end

                actions.select_default:replace(function()
                    local entry = action_state.get_selected_entry()
                    actions.close(bufnr)

                    if entry and entry[1] then
                        vim.o.guifont = entry[1]
                        vim.notify('Font set: ' .. entry[1], vim.log.levels.INFO)
                    end
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

    builtin.colorscheme { enable_preview = true }
    vim.api.nvim_create_autocmd('ColorScheme', {
        once = true, -- solo una vez tras escoger el nuevo esquema
        callback = function()
            bg_util:clear_cache()
            bg_util:start(false, true)
        end,
    })
end

M.lazy = true
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

M.config = function()
    local t = require 'telescope'
    local builtin = require 'telescope.builtin'
    local m = vim.keymap
    t.setup {}

    -- BUILTIN
    m.set('n', '<space>cb', builtin.buffers, { desc = 'Telescope=buffers' })
    m.set('n', '<space>gs', builtin.git_status, { desc = 'Telescope=Git status' })
    m.set('n', '<space>gf', builtin.git_files, { desc = 'Telescope=Git Files' })
    m.set('n', '<space>gc', builtin.git_commits, { desc = 'Telescope=Git commits' })
    m.set('n', '<space>gb', builtin.git_branches, { desc = 'Telescope=Git branches' })
    m.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope=Find Files' })
    m.set('n', '<space>h',  builtin.help_tags, { desc = 'Telescope=Help' })
    m.set('n', '<space>hk', builtin.keymaps, { desc = 'Telescope=keymaps' })
    m.set('n', '<space>lg', builtin.live_grep, { desc = 'Telescope=live grep' })
    -- CUSTOM
    m.set('n', '<space>cc', M.custom.colorscheme, { desc = 'Change colorscheme' })
    m.set('n', '<space>LG', M.custom.grep_string, { desc = 'Custom grep string' })
    m.set('n', '<space>pp', M.custom.list_plugins, { desc = 'Plugins installed' })
    m.set('n', '<space>fb', M.custom.list_buffers, { desc = 'Current folder file browser' })
    m.set('n', '<space>nf', M.custom.change_neovide_font, { desc = 'Change neovide fonts' })
end

return M
