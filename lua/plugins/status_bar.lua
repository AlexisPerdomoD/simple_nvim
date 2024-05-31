return {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      -- Configuración de galaxyline
      local gl = require('galaxyline')
      local condition = require('galaxyline.condition')
      local gls = gl.section

      -- Definir colores del tema Nord
      local colors = {
        nord0  = '#2E3440',
        nord1  = '#3B4252',
        nord2  = '#434C5E',
        nord3  = '#4C566A',
        nord4  = '#D8DEE9',
        nord5  = '#E5E9F0',
        nord6  = '#ECEFF4',
        nord7  = '#8FBCBB',
        nord8  = '#88C0D0',
        nord9  = '#81A1C1',
        nord10 = '#5E81AC',
        nord11 = '#BF616A',
        nord12 = '#D08770',
        nord13 = '#EBCB8B',
        nord14 = '#A3BE8C',
        nord15 = '#B48EAD',
      }

      gl.short_line_list = {'NvimTree', 'vista', 'dbui', 'packer'}

      -- Left side of the statusline
      gls.left[1] = {
        RainbowRed = {
          provider = function() return '▊ ' end,
          highlight = {colors.nord9, colors.nord0}
        },
      }

      gls.left[2] = {
        GitBranch = {
          provider = 'GitBranch',
          separator = ' ',
          condition = condition.check_git_workspace,
          highlight = {colors.nord13, colors.nord0, 'bold'},
        }
      }

      gls.left[3] = {
        FileName = {
          provider = 'FileName',
          highlight = {colors.nord8, colors.nord0, 'bold'}
        }
      }

      -- Right side of the statusline
      gls.right[1] = {
        FileEncode = {
          provider = 'FileEncode',
          condition = condition.hide_in_width,
          highlight = {colors.nord10, colors.nord0, 'bold'}
        }
      }

      gls.right[2] = {
        FileFormat = {
          provider = 'FileFormat',
          condition = condition.hide_in_width,
          highlight = {colors.nord10, colors.nord0, 'bold'}
        }
      }

      gls.right[3] = {
        LineInfo = {
          provider = 'LineColumn',
          highlight = {colors.nord4, colors.nord0},
        },
      }

      gls.right[4] = {
        PerCent = {
          provider = 'LinePercent',
          highlight = {colors.nord4, colors.nord0, 'bold'},
        }
      }

      gls.right[5] = {
        RainbowBlue = {
          provider = function() return ' ▊' end,
          highlight = {colors.nord9, colors.nord0}
        },
      }

      -- Disable mode indicator on short lines
      gls.short_line_left[1] = {
        BufferType = {
          provider = 'FileTypeName',
          separator = ' ',
          separator_highlight = { 'NONE', colors.nord0 },
          highlight = { colors.nord4, colors.nord0 }
        }
      }

      gls.short_line_left[2] = {
        SFileName = {
          provider = 'SFileName',
          condition = condition.buffer_not_empty,
          highlight = { colors.nord4, colors.nord0 }
        }
      }

      gls.short_line_right[1] = {
        BufferIcon = {
          provider = 'BufferIcon',
          highlight = { colors.nord4, colors.nord0 }
        }
      }
    end
  }
