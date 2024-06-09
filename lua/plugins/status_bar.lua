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
        bg = '#000000',         -- Background color
        fg = '#D8DEE9',         -- Foreground color
        black = '#2E3440',      -- Black
        red = '#BF616A',        -- Red
        green = '#A3BE8C',      -- Green (Git color)
        yellow = '#EBCB8B',     -- Yellow
        blue = '#81A1C1',       -- Blue
        magenta = '#B48EAD',    -- Magenta
        cyan = '#88C0D0',       -- Cyan
        white = '#ECEFF4',      -- White
        grey = '#4C566A',       -- Grey
        darkgrey = '#3B4252',   -- Dark Grey
        solidgrey = '#434C5E',  -- Solid Grey (Between almost black and silver)
      }

      gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

      -- Left side of the statusline
      gls.left[1] = {
        RainbowRed = {
          provider = function() return '▊ ' end,
          highlight = {colors.green, colors.bg}
        },
      }

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
            vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
            return '  '
          end,
          highlight = {colors.red, colors.bg, 'bold'},
        },
      }

      gls.left[3] = {
        GitBranch = {
          provider = 'GitBranch',
          separator = '',
          condition = condition.check_git_workspace,
          highlight = {colors.green, colors.bg, 'bold'},
        }
      }
    gls.left[4] = {
        RainbowRed = {
          provider = function() return '▊ asd' end,
          highlight = {colors.bg, colors.bg}
        },
      }
      gls.left[4] = {
        FileName = {
          provider = 'FileName',
          highlight = {colors.darkgrey, colors.bg, 'bold'}
        }
      }

      -- Right side of the statusline
      gls.right[1] = {
        FileEncode = {
          provider = 'FileEncode',
          condition = condition.hide_in_width,
          highlight = {colors.grey, colors.bg, 'bold'}
        }
      }

      gls.right[2] = {
        FileFormat = {
          provider = 'FileFormat',
          condition = condition.hide_in_width,
          highlight = {colors.green, colors.bg, 'bold'}
        }
      }

      gls.right[3] = {
        LineInfo = {
          provider = 'LineColumn',
          highlight = {colors.darkgrey, colors.bg},
        },
      }

      gls.right[4] = {
        PerCent = {
          provider = 'LinePercent',
          highlight = {colors.fg, colors.bg, 'bold'},
        }
      }

      gls.right[5] = {
        RainbowBlue = {
          provider = function() return ' ▊' end,
          highlight = {colors.green, colors.bg}
        },
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

      gls.short_line_right[1] = {
        BufferIcon = {
          provider = 'BufferIcon',
          highlight = { colors.fg, colors.bg }
        }
      }
    end
  }

