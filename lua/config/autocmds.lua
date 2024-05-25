-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- -- Create an augroup
local myAutoCmd = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })

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


-- Show hover documentation if no diagnostic
--vim.api.nvim_create_autocmd({"CursorHoldI", "CursorHold"}, {
--  callback = function()
--    if vim.fn['coc#float#has_float']() and vim.fn['CocHasProvider']('hover') == 1 and vim.fn['coc#rpc#ready']() then
--      vim.fn['CocActionAsync']('doHover')
--    end
--  end,
--  group = myAutoCmd,
-- })

