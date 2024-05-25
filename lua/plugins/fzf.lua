return {
  'junegunn/fzf.vim',
  requires = { 'junegunn/fzf' },
  build = function()
    -- Configura la ruta de instalación de fzf
    vim.g.fzf_path = '/home/sixela/external_repos/fz'

    -- Opcional: puedes configurar las opciones de fzf aquí
    vim.g.fzf_layout = { down = '40%' }

    -- Instala fzf.vim
    vim.fn['fzf#install']()
  end
}

--return {
  --'junegunn/fzf.vim',
  -- requires = { 'junegunn/fzf',dir = '~, build = './install --all'},
  -- requires = {'junegunn/fzf', build = 'fzf'},
  --config = function()
    -- Especifica la ruta de instalación de fzf
    --vim.g.fzf_path = '/home/linuxbrew/.linuxbrew/opt/fzf/bin/fzf'

    -- Opcional: puedes configurar las opciones de fzf aquí
    --vim.g.fzf_layout = { down = '40%' }
  --end
--}


-- return {
 -- 'junegunn/fzf.vim',
 -- run = function() vim.fn['fzf#install']() end,
 -- requires = { 'junegunn/fzf' },
 -- config = function()
 --   vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', { noremap = true, silent = true })
 --   vim.api.nvim_set_keymap('n', '<leader>g', ':GFiles<CR>', { noremap = true, silent = true })
--    vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', { noremap = true, silent = true })
 -- end
--}

