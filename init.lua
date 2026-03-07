if vim.g.neovide then
    local neovide_setup = require 'utils.neovide_setup'
    neovide_setup:init()
end

require 'config.options'
require 'config.autocmds'
require 'config.keymaps'
require 'config.lsp'
require 'config.lazy'
