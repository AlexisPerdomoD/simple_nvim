require 'config.opts'
require 'config.autocmds'
require 'config.keymaps'

local ui2 = require 'vim._core.ui2'
ui2.enable()

if vim.g.neovide then
    local cfg = require 'config.neovide'
    cfg:setup()
end

require 'config.lazy'

local t = require 'cyberdream'
t.setup {
    variant = 'muted',
    transparent = vim.g.neovide ~= nil,
    italic_comments = true,
    hide_fillchars = true,
    borderless_pickers = true,
}
-- builtin default colorscheme
-- vim.cmd 'colorscheme catppuccin'

-- current colorscheme
vim.cmd 'colorscheme cyberdream'
