-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- -- Create an augroup
local myAutoCmd = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })
local foldingCmd = vim.api.nvim_create_augroup("folding_comands", { clear = true })
local nodejsCmd = vim.api.nvim_create_augroup("NodeJSAutogroup", { clear = true })
-- Autocommands
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.lua",
    command = "source <afile>",
    group = myAutoCmd,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
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
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    group = foldingCmd,
    pattern = ".*",
    command = 'normal zR'
})
-- update files when they change on file system
vim.opt.autoread = true
vim.cmd [[
  augroup auto_read
    autocmd!
    autocmd FocusGained,BufEnter * checktime
  augroup END
]]

-- get npm when a js file is open
-- vim.cmd([[
--   augroup NodeJSAutogroup
--     autocmd!
--     autocmd BufRead,BufNewFile *.js,*.jsx,*.ts,*.tsx lua LoadNodeJS()
--   augroup END
-- ]], false)
--
-- function LoadNodeJS()
--     -- Verifica si las variables de entorno necesarias están configuradas
--     local nvm_dir = os.getenv("HOME") .. "/.nvm"
--     local nvm_sh = nvm_dir .. "/nvm.sh"
--     local bash_completion = nvm_dir .. "/bash_completion"
--
--     -- Carga las variables de entorno y fuentes de scripts si es necesario
--     if not vim.fn.filereadable(nvm_sh) == 1 then
--         return
--     end
--
--     if not vim.fn.filereadable(bash_completion) == 1 then
--         return
--     end
--
--     -- Ejecuta el source de los scripts
--     vim.cmd("source " .. nvm_sh)
--     vim.cmd("source " .. bash_completion)
--
--      -- Indica que NPM ha sido cargado
--     print("NPM cargado")
-- end
