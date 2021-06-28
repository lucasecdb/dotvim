local gl = require('galaxyline')
local colors = require('l.colors')
local condition = require('galaxyline.condition')
local gls = gl.section

gl.short_line_list = {'NvimTree','vista','dbui','packer', 'term'}

local mode_map = {
  ['__'] = '------',
  c  = 'COMMAND',
  i  = 'INSERT',
  ic = 'INSERT COMPL',
  ix = 'INSERT COMPL',
  multi = 'MULTI',
  n  = 'NORMAL',
  ni = '(INSERT)',
  no = 'OP PENDING',
  r  = 'PROMPT',
  ['r?'] = 'PROMPT',
  R  = 'REPLACE',
  Rv = 'V REPLACE',
  s  = 'SELECT',
  S  = 'S-LINE',
  [''] = 'S-BLOCK',
  t  = 'TERMINAL',
  v  = 'VISUAL',
  V  = 'V-LINE',
  ['\22'] = 'V-BLOCK',
}

gls.left = {
  {
    RainbowRed = {
      provider = function() return '▊ ' end,
      highlight = {colors.blue,colors.bg_alt}
    },
  },
  {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
        local mode_color = {
          -- Normal mode
          n = colors.red,
          no = colors.red,
          nov = colors.red,
          noV = colors.red,
          ['no\22'] = colors.red,
          -- Insert mode
          i = colors.green,
          ic = colors.yellow,
          -- Visual mode
          v = colors.blue,
          V = colors.blue,
          ['\22'] = colors.blue,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          -- Command-line mode
          c = colors.violet,
          cv = colors.red,
          ce = colors.red,
          -- Replace mode
          R = colors.violet,
          Rv = colors.violet,
          -- Other modes
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!']  = colors.red,
          t = colors.red,
        }

        vim.api.nvim_command('hi GalaxyViMode guifg=' .. (mode_color[vim.fn.mode()] or colors.blue))

        return (mode_map[vim.fn.mode()] or vim.fn.mode()) .. ' '
      end,
      highlight = {colors.red,colors.bg_alt,'bold'},
    },
  },
  {
    FileName = {
      provider = 'FileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.blue,colors.bg_alt,'bold'}
    }
  },
  {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = {colors.red,colors.bg_alt}
    }
  },
  {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '  ',
      highlight = {colors.yellow,colors.bg_alt},
    }
  },
  {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = '  ',
      highlight = {colors.cyan,colors.bg_alt},
    }
  },
  {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      highlight = {colors.blue,colors.bg_alt},
    }
  },
}

gls.right = {
  {
    LineInfo = {
      provider = 'LineColumn',
      separator = ' ',
      separator_highlight = {'NONE',colors.bg_alt},
      highlight = {colors.fg,colors.bg_alt},
    },
  },
  {
    PerCent = {
      provider = 'LinePercent',
      separator = ' ',
      separator_highlight = {'NONE',colors.bg_alt},
      highlight = {colors.fg,colors.bg_alt,'bold'},
    }
  },
  {
    FileIcon = {
      provider = 'FileTypeName',
      condition = condition.buffer_not_empty,
      highlight = {colors.fg,colors.bg_alt},
      separator = ' ',
      separator_highlight = {colors.fg, colors.bg_alt},
    },
  },
  {
    FileEncode = {
      provider = 'FileEncode',
      condition = condition.hide_in_width,
      separator = ' ',
      separator_highlight = {'NONE',colors.bg_alt},
      highlight = {colors.green,colors.bg_alt,'bold'}
    }
  },
  {
    FileFormat = {
      provider = 'FileFormat',
      condition = condition.hide_in_width,
      separator = ' ',
      separator_highlight = {'NONE',colors.bg_alt},
      highlight = {colors.green,colors.bg_alt,'bold'}
    }
  },
  {
    GitIcon = {
      provider = function() return '  ' end,
      condition = condition.check_git_workspace,
      separator = ' ',
      separator_highlight = {'NONE',colors.bg_alt},
      highlight = {colors.violet,colors.bg_alt,'bold'},
    }
  },
  {
    GitBranch = {
      provider = 'GitBranch',
      condition = condition.check_git_workspace,
      highlight = {colors.violet,colors.bg_alt,'bold'},
      separator = ' ',
      separator_highlight = {colors.fg, colors.bg_alt},
    },
  },
  {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = condition.hide_in_width,
      icon = '   ',
      highlight = {colors.green,colors.bg_alt},
    }
  },
  {
    DiffModified = {
      provider = 'DiffModified',
      condition = condition.hide_in_width,
      icon = ' 柳 ',
      highlight = {colors.orange,colors.bg_alt},
    }
  },
  {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = condition.hide_in_width,
      icon = '   ',
      highlight = {colors.red,colors.bg_alt},
    }
  },
  {
    RainbowBlue = {
      provider = function() return ' ▊' end,
      highlight = {colors.blue,colors.bg_alt},
      separator = ' ',
      separator_highlight = {colors.fg, colors.bg_alt},
    },
  },
}

gls.short_line_left = {
  {
    SFileName = {
      provider =  'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.fg,colors.bg_alt,'bold'}
    }
  },
  {
    BufferIcon = {
      provider= 'BufferIcon',
      highlight = {colors.fg,colors.bg_alt}
    }
  },
}

gls.short_line_right = {
  {
    BufferType = {
      provider = 'FileTypeName',
      highlight = {colors.blue,colors.bg_alt,'bold'},
      separator = ' ',
      separator_highlight = {colors.fg, colors.bg_alt},
    },
  },
}
