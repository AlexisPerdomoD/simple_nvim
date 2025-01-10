-- Ensure lazy.nvim is installed
local ensure_lazy = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            install_path,
        })
    end
    vim.opt.rtp:prepend(install_path)
end
ensure_lazy()
-- Load config
require("config")
-- Load plugins
require("lazy").setup("plugins")
-- color-scheme is set into the selected theme on "config/themes/"
--
if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_floating_corner_radius = 0.9
    vim.g.neovide_transparency = 1
    vim.o.guifont = "Iosevka Nerd Font:h10:b"
    vim.g.neovide_text_gamma = 0.5
    vim.g.neovide_text_contrast = 0.9
    vim.g.neovide_input_use_logo = true

    vim.g.neovide_refresh_rate = 165
    vim.g.neovide_refresh_rate_idle = 15

    vim.api.nvim_set_keymap("n", "<sc-v>", 'l"+P', { noremap = true })
    -- vim.api.nvim_set_keymap("v", "<sc-v>", '"+P', { noremap = true })
    vim.api.nvim_set_keymap("c", "<sc-v>", '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
    -- vim.api.nvim_set_keymap("i", "<sc-v>", '<ESC>l"+Pli', { noremap = true })
    vim.api.nvim_set_keymap("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })

    vim.api.nvim_set_keymap("v", "<sc-c>", '"+y', { noremap = true }) -- Select line(s) in visual mode and copy (CTRL+Shift+V)
    vim.api.nvim_set_keymap("i", "<sc-v>", '<ESC>"+p', { noremap = true }) -- Paste in insert mode (CTRL+Shift+C)
    vim.api.nvim_set_keymap("n", "<sc-v>", '"+p', { noremap = true }) -- paste in normal mode (ctrl+shift+c)
end
