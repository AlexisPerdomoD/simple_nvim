return {
    {'nvim-telescope/telescope.nvim', tag = '0.1.6'},
-- or                              , branch = '0.1.x',
      dependencies = { 
          'nvim-lua/plenary.nvim' ,
          'nvim-telescope/telescope-file-browser.nvim',
          {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
          }
        },
      event = 'veryLazy',
        opts = { -- nombre arbitrario para pasar de parametro a config
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    }
  },
  config = function(opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('fzf')
end,
  keys = {
{
"<space>gi",
function()
  require('telescope.builtin').git_files({ show_untracked = true })
end,
desc = "Telescope Git Files",
},
{
"<space>b",
function()
  require("telescope.builtin").buffers()
end,
desc = "Telescope buffers",
},
{
"<space>gs",
function()
  require("telescope.builtin").git_status()
end,
desc = "Telescope Git status",
},
{
"<space>gc",
function()
  require("telescope.builtin").git_bcommits()
end,
desc = "Telescope Git status",
},
{
"<space>gb",
function()
  require("telescope.builtin").git_branches()
end,
desc = "Telescope Git branches",
},
{
"<space>f",
function()
  require('telescope.builtin').find_files()
end,
desc = "Telescope Find Files",
},
{
"<space>hh",
function()
  require("telescope.builtin").help_tags()
end,
desc = "Telescope Help"
},
{
"<space>fb",
function()
  require("telescope").extensions.file_browser.file_browser({ path = "%:h:p", select_buffer = true })
end,
desc = "Telescope file browser"
},
{
  "<space>C",
  function()
      require("telescope.builtin").colorscheme()
  end,
  desc = 'ColorScheme Telescope'
},
{
  "<space>hk",
  function()
      require("telescope.builtin").keymaps()
  end,
  desc = 'Telescope keymaps'
},
{
  "<space>gs",
  function()
      require("telescope.builtin").grep_string()
  end,
  desc = 'Telescope grep string'
},

},
}









       
