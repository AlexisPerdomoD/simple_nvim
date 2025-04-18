local myAutoCmd = vim.api.nvim_create_augroup("MyAutoCmd", { clear = true })
local foldingCmd = vim.api.nvim_create_augroup("folding_comands", { clear = true })
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

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    group = foldingCmd,
    pattern = ".*",
    command = 'normal zR'
})
vim.opt.autoread = true
vim.cmd [[
  augroup auto_read
    autocmd!
    autocmd FocusGained,BufEnter * checktime
  augroup END
]]

local function center_cursor()
    local height = vim.api.nvim_win_get_height(0)
    vim.o.scrolloff = math.floor(height / 2)
end

-- Set scrolloff on startup and resize
vim.api.nvim_create_autocmd({ "VimResized", "BufEnter", "WinEnter" }, {
    callback = center_cursor,
})
