if vim.g.neovide then
    local neovide_cfg = require 'config.neovide'
    neovide_cfg:setup()
end
-- local ui2 = require 'vim._core.ui2'
-- ui2.enable { enable = true }

require 'config.options'
require 'config.autocmds'
require 'config.keymaps'
require 'config.lazy'
