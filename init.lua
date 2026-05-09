if vim.g.neovide then
    local cfg = require 'config.neovide'
    cfg:setup()
end

require 'config.opts'
require 'config.autocmds'
require 'config.keymaps'
require 'config.lazy'
