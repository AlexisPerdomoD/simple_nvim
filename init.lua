-- Ensure lazy.nvim is installed
---@type fun() : nil
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
require("config")
require("lazy").setup("plugins")

if vim.g.neovide then require("utils.neovide_setup")() end

vim.opt.lazyredraw = false
vim.o.cursorline = true
vim.o.termguicolors = true
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1e1e2e", fg = "NONE", underline = false })
vim.o.guicursor = table.concat({
    "n-v-c:block", -- Bloque completo en modos normal, visual y de comando
    "i-ci-ve:ver25", -- Cursor vertical en inserción y selectores
    "r-cr:hor20", -- Cursor horizontal más pequeño en reemplazo
    "a:blinkon100", -- Parpadeo para todos los modos
    "sm:block-blinkwait175-blinkon150-blinkoff150", -- Parpadeo especial para modo de sustitución
}, ",")

require("utils.cmp_border_setuper")()
