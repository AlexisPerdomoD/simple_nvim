local T = { 'projekt0n/github-nvim-theme' }
T.name = 'github-theme'
T.lazy = true
-- T.priority = 1000
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
    local bg_utils = require 'utils.bg_color_setuper'

    github_theme.setup(opts)
    vim.cmd 'colorscheme github_dark_default'
    bg_utils:bg_setuper(false, true)
end

return T
