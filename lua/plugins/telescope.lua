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

    local p = pickers.new({}, {
        prompt_title = 'Select Neovide Font',
        finder = finders.new_table {
            results = fonts,
        },
        sorter = conf.generic_sorter {},
        attach_mappings = function(bufnr, _)
            local pick = action_state.get_current_picker(bufnr)

            -- cache original set_selection
            local original_set_selection = pick.set_selection

            -- override selection change (REAL hook point)
            pick.set_selection = function(self, row)
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

    p:find()
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

M.event = 'VeryLazy'
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
    t.setup {}

    -- BUILTIN
    vim.keymap.set('n', '<space>gD', builtin.lsp_definitions, { desc = 'Telescope=LSP Definitions' })
    vim.keymap.set('n', '<space>gT', builtin.lsp_type_definitions, { desc = 'Telescope=LSP Type Definitions' })
    vim.keymap.set('n', '<space>gR', builtin.lsp_references, { desc = 'Telescope=LSP References' })
    vim.keymap.set('n', '<space>gI', builtin.lsp_implementations, { desc = 'Telescope=LSP Implementations' })
    vim.keymap.set('n', '<space>wd', builtin.diagnostics, { desc = 'Telescope=Workspace Diagnostics' })
    vim.keymap.set('n', '<space>wb', function()
        builtin.diagnostics { bufnr = 0 }
    end, { desc = 'Telescope=Current Buffer Diagnostics' })
    vim.keymap.set('n', '<space>cc', function()
        builtin.colorscheme { enable_preview = true }
    end, { desc = 'Change colorscheme' })

    vim.keymap.set('n', '<space>cb', builtin.buffers, { desc = 'Telescope=buffers' })
    vim.keymap.set('n', '<space>gs', builtin.git_status, { desc = 'Telescope=Git status' })
    vim.keymap.set('n', '<space>gf', builtin.git_files, { desc = 'Telescope=Git Files' })
    vim.keymap.set('n', '<space>gc', builtin.git_commits, { desc = 'Telescope=Git commits' })
    vim.keymap.set('n', '<space>gb', builtin.git_branches, { desc = 'Telescope=Git branches' })
    vim.keymap.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope=Find Files' })
    vim.keymap.set('n', '<space>h', builtin.help_tags, { desc = 'Telescope=Help' })
    vim.keymap.set('n', '<space>hk', builtin.keymaps, { desc = 'Telescope=keymaps' })
    vim.keymap.set('n', '<space>lg', builtin.live_grep, { desc = 'Telescope=live grep' })

    -- CUSTOM
    vim.keymap.set('n', '<space>LG', M.custom.grep_string, { desc = 'Custom grep string' })
    vim.keymap.set('n', '<space>pp', M.custom.list_plugins, { desc = 'Plugins installed' })
    vim.keymap.set('n', '<space>fb', M.custom.list_buffers, { desc = 'Current folder file browser' })
    vim.keymap.set('n', '<space>nf', M.custom.change_neovide_font, { desc = 'Change neovide fonts' })
end

return M
