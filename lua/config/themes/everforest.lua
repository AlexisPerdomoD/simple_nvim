local M = {
  "neanias/everforest-nvim",
  lazy = true,
 --  event = "VeryLazy",
 -- priority = 1000, -- make sure to load this before all the other start plugins
  --priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  local everforest = require("everforest")
  everforest.setup({
    background = "hard",
    transparent_background_level = 0,
     float_style = "dim",
        inlay_hints_background = "dimmed",
    italics = true,
    disable_italic_comments = false,
    on_highlights = function(hl, _)
      hl["@string.special.symbol.ruby"] = { link = "@field" }
    end,
  })
 --    vim.cmd "g.everforest_colors_override = {'bg0': ['#000', '234'], 'bg2': ['#000', '235']}"
 -- everforest.load()
end
return M
