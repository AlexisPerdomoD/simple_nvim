local T = { 'aymenhafeez/doric-themes.nvim' }
T.name = 'doric'
T.config = function()
    vim.cmd.colorscheme 'doric-mermaid'
    require('utils.bg_color_setuper'):bg_setuper(false, true)
end

return T
