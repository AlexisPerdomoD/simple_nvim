local M = {}
---
--- @param delta number
function M:set_transparency(delta)
    local currentOpacityPercentage = vim.g.neovide_opacity + delta
    vim.g.neovide_opacity = math.min(1.0, math.max(0.1, currentOpacityPercentage))
    self.last_notify = vim.notify('Opacity set to ' .. vim.g.neovide_opacity * 100 .. '%', vim.log.levels.INFO)
end

function M:set_scale(delta)
    local currentScale = vim.g.neovide_scale_factor + delta
    vim.g.neovide_scale_factor = math.min(2.0, math.max(0.1, currentScale))
end

--- set environment variables for neovide
function M.set_env()
    local java_home = os.getenv 'HOME' .. '/.sdkman/candidates/java/current'
    vim.fn.setenv('JAVA_HOME', java_home)
    vim.fn.setenv('PATH', java_home .. '/bin:' .. os.getenv 'PATH')
end

function M:set_keymaps()
    vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', { noremap = true, desc = 'Select line(s) in normal mode and copy' })
    vim.api.nvim_set_keymap(
        'c',
        '<sc-v>',
        '<C-o>l<C-o>"+<C-o>P<C-o>l',
        { noremap = true, desc = 'Select line(s) in normal mode and copy' }
    )
    vim.api.nvim_set_keymap(
        't',
        '<sc-v>',
        '<Cd\\><C-n>"+Pi',
        { noremap = true, desc = 'Select line(s) in normal mode and copy' }
    )
    vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', { noremap = true, desc = 'Copy visually selected text' })
    vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>"+p', {
        noremap = true,
        desc = 'Paste in insert mode (CTRL+Shift+v)',
    })
    vim.api.nvim_set_keymap('t', '<sc-v>', '<ESC>"+p', { noremap = true, desc = 'Paste in insert mode (CTRL+Shift+v)' })
    vim.api.nvim_set_keymap('n', '<sc-v>', '"+p', { noremap = true, desc = 'Paste in normal mode (CTRL+Shift+v)' })
    vim.keymap.set(
        'n',
        '<C-=>',
        function() self:set_scale(0.05) end,
        { noremap = true, desc = 'Increase scale factor' }
    )
    vim.keymap.set(
        'n',
        '<C-->',
        function() self:set_scale(-0.05) end,
        { noremap = true, desc = 'Decrease scale factor' }
    )
    vim.keymap.set('n', '<C-)>', function() self:set_transparency(0.05) end)
    vim.keymap.set('n', '<C-(>', function() self:set_transparency(-0.05) end)
end

function M:init()
    vim.g.neovide_cursor_vfx_mode = 'railgun'
    -- vim.o.guifont = 'FantasqueSansM Nerd Font:h10'
    vim.o.guifont = 'JetBrainsMono Nerd Font:h10'
    -- vim.o.guifont = 'MartianMono Nerd Font:h8'
    vim.g.neovide_text_gamma = 1
    vim.g.neovide_text_contrast = 1
    vim.g.neovide_input_use_logo = true
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_refresh_rate_idle = 15
    vim.g.neovide_opacity = 0.8
    vim.g.transparency = 1
    vim.opt.linespace = 2
    vim.g.neovide_floating_corner_radius = 0.5

    self.set_env()
    self:set_keymaps()
end

return M
