if vim.g.neovide then
    local neovide_cfg = require 'config.neovide'
    neovide_cfg:setup()
end

require 'config.options'
require 'config.autocmds'
require 'config.keymaps'
require 'config.lazy'
