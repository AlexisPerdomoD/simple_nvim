local T = { 'Mofiqul/dracula.nvim' }
T.config = function()
    local theme = require 'dracula'
    local bg_utils = require 'utils.bg_color_setuper'
    theme.setup {
        italic_comment = true,
        transparent_bg = false,
    }

    vim.cmd 'colorscheme dracula'
    bg_utils:bg_setuper(false, true)
end

return T
