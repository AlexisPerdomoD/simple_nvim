return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    config = function()
        local harpoon = require 'harpoon'

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set('n', '<space>a', function()
            harpoon:list():add()
            local filename = vim.fn.expand '%:t' -- o usa vim.fn.expand("%:t") solo para el nombre
            vim.notify('Archivo agregado a Harpoon: ' .. filename, vim.log.levels.INFO, { title = 'Harpoon' })
        end)
        vim.keymap.set('n', '<space>e', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set('n', '<space>1', function() harpoon:list():select(1) end)
        vim.keymap.set('n', '<space>2', function() harpoon:list():select(2) end)
        vim.keymap.set('n', '<space>3', function() harpoon:list():select(3) end)
        vim.keymap.set('n', '<space>4', function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set('n', '<space>|', function() harpoon:list():prev() end)
        vim.keymap.set('n', '<space>\\', function() harpoon:list():next() end)
    end,
}
