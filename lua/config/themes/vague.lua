local T = { 'vague-theme/vague.nvim' }
T.name = 'vague'
T.default_colors = {
    bg = '#141415',
    inactiveBg = '#1c1c24',
    fg = '#cdcdcd',
    floatBorder = '#878787',
    line = '#252530',
    comment = '#606079',
    builtin = '#b4d4cf',
    func = '#c48282',
    string = '#e8b589',
    number = '#e0a363',
    property = '#c3c3d5',
    constant = '#aeaed1',
    parameter = '#bb9dbd',
    visual = '#333738',
    error = '#d8647e',
    warning = '#f3be7c',
    hint = '#7e98e8',
    operator = '#90a0b5',
    keyword = '#6e94b2',
    type = '#9bb4bc',
    search = '#405065',
    plus = '#7fa563',
    delta = '#f3be7c',
}

T.transparent = false
T.bold = true
T.italic = true
T.on_highlights = function(highlights, colors) end

T.config = function()
    local theme = require 'vague'
    theme.setup {
        -- Don't set background
        transparent = T.transparent,
        -- Disable bold/italic globally
        bold = T.bold,
        italic = T.italic,

        -- Override highlights or add new highlights
        on_highlights = T.on_highlights,

        -- Override colors
        colors = T.default_colors,
    }
    vim.cmd 'colorscheme vague'
end

return T
