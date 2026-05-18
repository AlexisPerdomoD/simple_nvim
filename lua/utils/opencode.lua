-- opencode panel
local M = {}
M.win = nil
M.buf = nil

local WIDTH = 80

local function open()
    vim.cmd 'topleft vsplit'
    M.win = vim.api.nvim_get_current_win()
    vim.wo[M.win].winfixwidth = true
    vim.api.nvim_win_set_width(M.win, WIDTH)

    if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
        vim.api.nvim_win_set_buf(M.win, M.buf)
    else
        vim.cmd 'terminal opencode --continue'
        M.buf = vim.api.nvim_get_current_buf()
        vim.bo[M.buf].buflisted = false
    end

    local grp = vim.api.nvim_create_augroup('OpenCodePanel', { clear = true })
    vim.api.nvim_create_autocmd('WinResized', {
        callback = function()
            if not M.win or not vim.api.nvim_win_is_valid(M.win) then
                return
            end

            vim.api.nvim_win_set_width(M.win, WIDTH)
        end,
        group = grp,
    })

    vim.api.nvim_create_autocmd('TermClose', {
        callback = function(ev)
            if ev.buf ~= M.buf then
                return
            end

            M.buf = nil
            M.win = nil
        end,
        group = grp,
    })

    vim.cmd 'startinsert'
end

local function close()
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_win_close(M.win, false)
    end
    M.win = nil
end

local function toggle()
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        close()
        return
    end

    open()
end

local function focus()
    if not M.win or not vim.api.nvim_win_is_valid(M.win) then
        open()
        return
    end
    vim.api.nvim_set_current_win(M.win)
    vim.cmd 'startinsert'
end

return { open = open, close = close, toggle = toggle, focus = focus }
