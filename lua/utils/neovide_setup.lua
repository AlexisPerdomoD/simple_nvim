return function()
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_floating_corner_radius = 0.9
    vim.o.guifont = "FantasqueSansM Nerd Font:h10"
    vim.g.neovide_text_gamma = 0.9
    vim.g.neovide_text_contrast = 1
    vim.g.neovide_input_use_logo = true

    vim.g.neovide_refresh_rate = 165
    vim.g.neovide_refresh_rate_idle = 15
    vim.g.neovide_opacity = 0.9
    vim.api.nvim_set_keymap("n", "<sc-v>", 'l"+P', { noremap = true })
    vim.api.nvim_set_keymap("c", "<sc-v>", '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
    vim.api.nvim_set_keymap("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })
    vim.api.nvim_set_keymap("v", "<sc-c>", '"+y', { noremap = true })      -- Select line(s) in visual mode and copy (CTRL+Shift+V)
    vim.api.nvim_set_keymap("i", "<sc-v>", '<ESC>"+p', { noremap = true }) -- Paste in insert mode (CTRL+Shift+C)
    vim.api.nvim_set_keymap("n", "<sc-v>", '"+p', { noremap = true })      -- paste in normal mode (ctrl+shift+c)


    vim.keymap.set("n", "<C-=>", function()
        vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) + 0.05
    end, { noremap = true })

    vim.keymap.set("n", "<C-->", function()
        vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) - 0.05
    end, { noremap = true })
end
