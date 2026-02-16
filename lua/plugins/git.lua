local vim_fugitive = { 'tpope/vim-fugitive' }
vim_fugitive.event = 'VeryLazy'
vim_fugitive.cmd = { 'Git', 'G' }

local gitsigns = { 'lewis6991/gitsigns.nvim' }
gitsigns.event = 'VeryLazy'
gitsigns.config_2 = function()
    require('gitsigns').setup()

    vim.keymap.set('n', '<space>gt', ':Gitsigns= blame_line<CR>', { silent = true })
    vim.keymap.set('n', '<space>ph', ':Gitsigns= preview_hunk<CR>', { silent = true })
end

gitsigns.config = function()
    require('gitsigns').setup {
        signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
        },
        current_line_blame = true, -- ver blame inline
        current_line_blame_opts = { delay = 1000 },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            -- Navegación entre hunks
            vim.keymap.set('n', ']h', gs.next_hunk, { buffer = bufnr, desc = 'Gitsigns:Next hunk', silent = true })
            vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = bufnr, desc = 'Gitsigns:Prev hunk', silent = true })

            -- Stage / Reset hunks
            vim.keymap.set(
                'n',
                '<leader>hs',
                gs.stage_hunk,
                { buffer = bufnr, desc = 'Gitsign:Stage hunk', silent = true }
            )
            vim.keymap.set(
                'v',
                '<leader>hs',
                function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
                { buffer = bufnr, desc = 'Gitsign:Stage hunk', silent = true }
            )
            vim.keymap.set(
                'n',
                '<leader>hr',
                gs.reset_hunk,
                { buffer = bufnr, desc = 'Gitsign:Reset hunk', silent = true }
            )
            vim.keymap.set(
                'v',
                '<leader>hr',
                function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
                { buffer = bufnr, desc = 'Gitsign:Reset hunk', silent = true }
            )

            -- Stage / Reset buffer
            vim.keymap.set(
                'n',
                '<leader>hS',
                gs.stage_buffer,
                { buffer = bufnr, desc = 'Gitsign:Stage buffer', silent = true }
            )
            vim.keymap.set(
                'n',
                '<leader>hR',
                gs.reset_buffer,
                { buffer = bufnr, desc = 'Gitsign:Reset buffer', silent = true }
            )

            -- Preview / blame
            vim.keymap.set(
                'n',
                '<leader>hp',
                gs.preview_hunk,
                { buffer = bufnr, desc = 'Gitsign:Preview hunk', silent = true }
            )
            vim.keymap.set(
                'n',
                '<leader>hb',
                gs.blame_line,
                { buffer = bufnr, desc = 'Gitsign:Blame line', silent = true }
            )

            -- Diff / toggle deleted
            vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Gitsign:Diffthis', silent = true })
            vim.keymap.set(
                'n',
                '<leader>hD',
                function() gs.diffthis '~' end,
                { buffer = bufnr, desc = 'Gitsign:Diffthis', silent = true }
            )

            -- Toggle signs / line blame
            vim.keymap.set(
                'n',
                '<leader>ht',
                gs.toggle_signs,
                { buffer = bufnr, desc = 'Gitsign:Toggle signs', silent = true }
            )
            vim.keymap.set(
                'n',
                '<leader>hB',
                gs.toggle_current_line_blame,
                { buffer = bufnr, desc = 'Gitsign:Toggle line blame', silent = true }
            )
        end,
    }
end

return { vim_fugitive, gitsigns }
