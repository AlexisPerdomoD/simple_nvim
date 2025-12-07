local M = {}
---
--- @param delta number
function M:set_transparency(delta)
    local currentOpacityPercentage = vim.g.neovide_opacity + delta
    vim.g.neovide_opacity = math.min(1.0, math.max(0.1, currentOpacityPercentage))
    self.last_notify = vim.notify('Opacity set to ' .. vim.g.neovide_opacity * 100 .. '%', vim.log.levels.INFO)
end

--- set environment variables for neovide
function M.set_env()
    local java_home = os.getenv 'HOME' .. '/.sdkman/candidates/java/current'
    vim.fn.setenv('JAVA_HOME', java_home)
    vim.fn.setenv('PATH', java_home .. '/bin:' .. os.getenv 'PATH')
end

function M.set_keymaps()
    vim.api.nvim_set_keymap('n', '<sc-v>', 'l"+P', { noremap = true })
    vim.api.nvim_set_keymap('c', '<sc-v>', '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
    vim.api.nvim_set_keymap('t', '<sc-v>', '<Cd\\><C-n>"+Pi', { noremap = true })
    vim.api.nvim_set_keymap('v', '<sc-c>', '"+y', { noremap = true }) -- Select line(s) in visual mode and copy (CTRL+Shift+V)
    vim.api.nvim_set_keymap('i', '<sc-v>', '<ESC>"+p', { noremap = true }) -- Paste in insert mode (CTRL+Shift+v)
    vim.api.nvim_set_keymap('n', '<sc-v>', '"+p', { noremap = true }) -- paste in normal mode (ctrl+shift+v)

    vim.keymap.set(
        'n',
        '<C-=>',
        function() vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) + 0.05 end,
        { noremap = true }
    )

    vim.keymap.set(
        'n',
        '<C-->',
        function() vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) - 0.05 end,
        { noremap = true }
    )
end

function M:init()
    vim.g.neovide_cursor_vfx_mode = 'railgun'
    vim.o.guifont = 'FantasqueSansM Nerd Font:h12'
    -- vim.o.guifont = 'MartianMono Nerd Font:h8'
    -- vim.o.guifont = 'JetBrainsMono Nerd Font:h11'
    vim.g.neovide_text_gamma = 1
    vim.g.neovide_text_contrast = 1
    vim.g.neovide_input_use_logo = true
    -- vim.g.neovide_refresh_rate = 165
    vim.g.neovide_refresh_rate_idle = 15
    vim.g.neovide_opacity = 0.8
    vim.g.transparency = 1
    vim.opt.linespace = 2
    vim.g.neovide_floating_corner_radius = 0.5

    self.set_env()
    self.set_keymaps()
    vim.keymap.set('n', '<C-)>', function() self:set_transparency(0.05) end)
    vim.keymap.set('n', '<C-(>', function() self:set_transparency(-0.05) end)
end

return M
