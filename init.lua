require 'config.opts'
require 'config.autocmds'
require 'config.keymaps'

local ui2 = require 'vim._core.ui2'
ui2.enable()
vim.cmd 'colorscheme catppuccin'

if vim.g.neovide then
    local cfg = require 'config.neovide'
    cfg:setup()
end

require 'config.lazy'
