return {
  'scrooloose/nerdtree',
  config = function()
    -- NERDTree settings
    -- Configuración de NERDTree
	vim.g.NERDTreeAutoRefresh = 1
	vim.g.NERDTreeQuitOnOpen = 1
    -- Key mapping to toggle NERDTree
    vim.api.nvim_set_keymap('n', '<leader>nt', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
  end
}


