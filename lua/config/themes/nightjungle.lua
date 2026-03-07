local T = { 'tx3stn/nightjungle.nvim' }
T.name = 'nightjungle'
T.config = function()
    require('nightjungle').setup {}
    vim.cmd.colorscheme 'nightjungle'
end

return T
