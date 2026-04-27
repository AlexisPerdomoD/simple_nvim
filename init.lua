if vim.g.neovide then
    local cfg = require 'config.neovide'
    cfg:setup()
end

require 'config.options'
require 'config.autocmds'
require 'config.keymaps'
require 'config.lazy'
