return {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        -- Configuración de galaxyline
        local gl = require('galaxyline')
        local condition = require('galaxyline.condition')
        local gls = gl.section

        -- Definir colores genéricos
        local colors = {
            bg = '#121218',        -- Background color
            fg = '#D8DEE9',        -- Foreground color
            black = '#2E3440',     -- Black
            red = '#BF616A',       -- Red
            green = '#A3BE8C',     -- Green (Git color)
            yellow = '#EBCB8B',    -- Yellow
            blue = '#81A1C1',      -- Blue
            magenta = '#B48EAD',   -- Magenta
            cyan = '#88C0D0',      -- Cyan
            white = '#ECEFF4',     -- White
            grey = '#4C566A',      -- Grey
            darkgrey = '#3B4252',  -- Dark Grey
            solidgrey = '#434C5E', -- Solid Grey (Between almost black and silver)
        }

        gl.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }

        -- Left side of the statusline
        -- Mode indicator
        gls.left[2] = {
            ViMode = {
                provider = function()
                    local mode_color = {
                        n = colors.green,
                        i = colors.blue,
                        v = colors.magenta,
                        [''] = colors.magenta,
                        V = colors.magenta,
                        c = colors.red,
                        no = colors.red,
                        s = colors.orange,
                        S = colors.orange,
                        [''] = colors.orange,
                        ic = colors.yellow,
                        R = colors.violet,
                        Rv = colors.violet,
                        cv = colors.red,
                        ce = colors.red,
                        r = colors.cyan,
                        rm = colors.cyan,
                        ['r?'] = colors.cyan,
                        ['!'] = colors.red,
                        t = colors.red,
                    }
                    vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
                    return '  💀  '
                end,
                highlight = { colors.red, colors.bg, 'bold' },
            },
        }

        gls.left[3] = {
            GitBranch = {
                provider = 'GitBranch',
                condition = condition.check_git_workspace,
                highlight = { colors.green, colors.bg, 'bold' },
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
            }
        }
        gls.left[4] = {
            FileName = {
                provider = 'FileName',
                highlight = { colors.darkgrey, colors.bg, 'bold' },
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
            }
        }

        -- Right side of the statusline
        gls.right[1] = {
            FileEncode = {
                provider = 'FileEncode',
                condition = condition.hide_in_width,
                highlight = { colors.grey, colors.bg, 'bold' },
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
            }
        }

        gls.right[2] = {
            FileFormat = {
                provider = 'FileFormat',
                condition = condition.hide_in_width,
                highlight = { colors.green, colors.bg, 'bold' },
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
            }
        }

        gls.right[3] = {
            LineInfo = {
                provider = 'LineColumn',
                highlight = { colors.darkgrey, colors.bg },
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
            },
        }

        gls.right[4] = {
            PerCent = {
                provider = 'LinePercent',
                highlight = { colors.fg, colors.bg, 'bold' },

            }
        }


        -- Disable mode indicator on short lines
        gls.short_line_left[1] = {
            BufferType = {
                provider = 'FileTypeName',
                separator = ' ',
                separator_highlight = { 'NONE', colors.bg },
                highlight = { colors.fg, colors.bg }
            }
        }

        gls.short_line_left[2] = {
            SFileName = {
                provider = 'SFileName',
                condition = condition.buffer_not_empty,
                highlight = { colors.fg, colors.bg }
            }
        }

        -- gls.short_line_right[0] = {
        --   BufferIcon = {
        --     provider = 'BufferIcon',
        --     highlight = { colors.fg, colors.bg }
        --   }
        -- }
        vim.opt.laststatus = 3 -- Usa una sola barra de estado global
    end
}
