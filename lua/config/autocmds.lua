local custom_group = vim.api.nvim_create_augroup('CustomGroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = custom_group,
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.md',
    command = 'setlocal spell',
    group = custom_group,
    desc = 'set spell on markdown',
})

vim.api.nvim_create_autocmd({ 'VimResized', 'BufEnter', 'WinEnter' }, {
    callback = function()
        local height = vim.api.nvim_win_get_height(0)
        vim.o.scrolloff = math.floor(height / 2)
    end,
    group = custom_group,
    desc = 'Keep centered cursor',
})

vim.api.nvim_create_autocmd('BufReadPre', {
    callback = function(args)
        local filesize_ckr = require 'utils.file_size'
        local large_file = filesize_ckr.is_too_large(args.file)

        vim.b[args.buf].large_file = large_file
        if not large_file then
            return
        end

        -- treesitter
        pcall(vim.treesitter.stop, args.buf)

        -- folds
        -- vim.wo[0].foldmethod = 'manual'
        vim.wo[vim.fn.bufwinid(args.buf)].foldmethod = 'manual'
        -- swap/undo
        vim.bo[args.buf].swapfile = false
        vim.bo[args.buf].undofile = false

        -- cmp / blink / ai plugins flag
        vim.b[args.buf].completion = false

        -- syntax
        vim.schedule(function()
            vim.cmd.syntax 'off'
            for _, client in
                ipairs(vim.lsp.get_clients {
                    bufnr = args.buf,
                })
            do
                vim.lsp.buf_detach_client(args.buf, client.id)
            end

            local stats = vim.loop.fs_stat(args.file)

            if not stats then
                return
            end

            local function notify_cb()
                vim.notify(
                    ('Large file detected (%0.2f MB), lite mode enabled'):format(stats.size / 1024 / 1024),
                    vim.log.levels.WARN
                )
            end

            vim.schedule(notify_cb)
        end)
    end,
})
