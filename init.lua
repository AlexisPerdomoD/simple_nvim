require 'config.opts'
require 'config.autocmds'
require 'config.keymaps'

local ui2 = require 'vim._core.ui2'
ui2.enable()

if vim.g.neovide then
    local cfg = require 'config.neovide'
    cfg:setup()
end

if vim.fn.getenv 'TERM' == 'xterm-kitty' then
    vim.g.__extra_colorscheme_name = 'biscuit'
else
    vim.g.__extra_colorscheme_name = 'duskhaven'
end

require 'config.lazy'
