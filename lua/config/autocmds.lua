-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- -- Create an augroup
local myAutoCmd = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })
local foldingCmd = vim.api.nvim_create_augroup("folding_comands", {clear = true})
-- Autocommands
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.lua",
  command = "source <afile>",
  group = myAutoCmd,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.md",
  command = "setlocal spell",
  group = myAutoCmd,
})
-- Autocomandos para excepciones de indentación para archivos HTML, JSX y TSX
vim.cmd([[
  augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead *.html,*.jsx,*.tsx setlocal shiftwidth=2
  augroup END
]])

-- Define un autocomando para abrir todos los folds al cargar un archivo
vim.api.nvim_create_autocmd({"BufReadPost", "FileReadPost"}, {
  group = foldingCmd,
  pattern = ".*",
  command = 'normal zR'
})


