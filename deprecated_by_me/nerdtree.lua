return {
    'scrooloose/nerdtree',
    dependencies = { 'ryanoasis/vim-devicons' },
    config = function()
        -- NERDTree settings
        -- Configuración de NERDTree
        vim.g.NERDTreeAutoRefresh = 1
        vim.g.NERDTreeQuitOnOpen = 1
        -- update root when opening a NERDTree
        vim.cmd [[
            augroup nerdtree_auto_refresh
    autocmd!
    autocmd BufEnter * if exists("t:NERDTreeBufName") && bufname("%") == t:NERDTreeBufName | execute 'NERDTreeRefreshRoot' | endif
    autocmd FocusGained * if exists("t:NERDTreeBufName") && bufname("%") == t:NERDTreeBufName | execute 'NERDTreeRefreshRoot' | endif
  augroup END
]]

        -- Key mapping to toggle NERDTree
        vim.api.nvim_set_keymap('n', '<leader>nt', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
    end
}
