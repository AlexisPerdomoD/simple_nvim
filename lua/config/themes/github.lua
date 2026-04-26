local T = { 'projekt0n/github-nvim-theme' }
T.name = 'github-theme'
T.config = function(opts)
    opts = opts
        or {
            options = {
                styles = {
                    comments = 'italic',
                    keywords = 'bold',
                    types = 'italic,bold',
                },
            },
        }

    local github_theme = require 'github-theme'

    github_theme.setup(opts)
    vim.cmd 'colorscheme github_dark_default'

    local bg = require 'utils.bg_color_setuper'
    bg:bg_setuper(false, true)
end

return T
