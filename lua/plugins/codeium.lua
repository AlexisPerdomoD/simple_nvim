return {
    "Exafunction/codeium.vim",
    -- dependencies = {
    --     "nvim-lua/plenary.nvim",
    --     "hrsh7th/nvim-cmp",
    -- }, uses for comunity extention folks if want to include into comands ia suggestions
    event = 'BufEnter',
    opts = {
        delay = 100,
        ignore_whitespace = false,
         suggestion = {
             enabled = true,
        --     auto_trigger = true,
             debounce = 75,
             keymap = {
                 accept = "<C-a>",
        --         next = "<C-n>",
        --         prev = "<C-p>",
        --         dismiss = "<C-e>",
             },
         },
    },
    config = function(opts)
        vim.keymap.set('i', '<C-a>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#CycleCompletions'](1) end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<c-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
            { expr = true, silent = true })
        -- disabled for now
        vim.keymap.set('i', '<c-u>', function() return vim.fn['codeium#Reset']() end, { expr = true })

    end
    --     vim.keymap.set('i', '<C-e>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    --     vim.keymap.set('i', '<c-n>', function() return vim.fn['codeium#CycleCompletions'](1) end,
    --         { expr = true, silent = true })
    --     vim.keymap.set('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
    --         { expr = true, silent = true })
    --     vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    -- end
}
