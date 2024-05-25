 function Toggle_nord_background()
  if vim.g.nord_disable_background then
    vim.g.nord_disable_background = false
  else
    vim.g.nord_disable_background = true
  end
  vim.cmd('colorscheme nord') -- Reapplies the colorscheme
end

return{
    'shaunsingh/nord.nvim',
    priority = 100,
    lazy = false,
    config = function ()
        --Lua:
        -- Example config in lua
        vim.g.nord_contrast = true
        vim.g.nord_borders = false
        vim.g.nord_disable_background = true
        --vim.g.nord_italic = false
        --vim.g.nord_uniform_diff_background = true
        vim.g.nord_enable_sidebar_background = true
        vim.g.nord_bold = true
        vim.cmd[[colorscheme nord]]
        -- Key mapping to toggle background
      vim.api.nvim_set_keymap('n', '<leader>tb', ':lua Toggle_nord_background()<CR>', { noremap = true, silent = true })
    end
}
