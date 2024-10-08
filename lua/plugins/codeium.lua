return {
    "Exafunction/codeium.vim",
    -- dependencies = {
    --     "nvim-lua/plenary.nvim",
    --     "hrsh7th/nvim-cmp",
    -- }, uses for comunity extention folks if want to include into comands ia suggestions
    lazy = true,
    opts = {
        delay = 100,
        ignore_whitespace = false,
        suggestion = {
            enabled = false,
            --     auto_trigger = true,
            debounce = 75,
            --      keymap = {
            --          accept = "<C-a>",
            -- --         next = "<C-n>",
            -- --         prev = "<C-p>",
            -- --         dismiss = "<C-e>",
            --      },
        },
    },
    config = function(_opts)
        vim.g.codeium_enabled = false
        -- disable default bindings
        vim.g.codeium_disable_bindings = 1
        vim.keymap.set('i', '<C-i>a', '<Esc>:CodeiumEnable<CR>a', { silent = false })
        vim.keymap.set('i', '<C-a>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-w>', function() return vim.fn['codeium#AcceptNextWord']() end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#AcceptNextLine']() end,
            { expr = true, silent = true })

        vim.keymap.set('i', '<C-c>', function() return vim.fn['codeium#Chat']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#CycleCompletions'](1) end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<c-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
            { expr = true, silent = true })

        -- disabled for now
        vim.keymap.set('i', '<C-u>', function() return vim.fn['codeium#Reset']() end, { expr = true })
        vim.keymap.set('i', '<Esc>', '<Esc>', { silent = true })
    end
    --     vim.keymap.set('i', '<C-e>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    --     vim.keymap.set('i', '<c-n>', function() return vim.fn['codeium#CycleCompletions'](1) end,
    --         { expr = true, silent = true })
    --     vim.keymap.set('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
    --         { expr = true, silent = true })
    --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    -- end
}
-- Accept word from suggestion 	codeium#AcceptNextWord() 	<C-k>
-- Accept line from suggestion 	codeium#AcceptNextLine() 	<C-l>
