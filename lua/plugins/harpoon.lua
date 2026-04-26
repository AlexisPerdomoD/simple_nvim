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
            vim.notify(
                'Archivo agregado a Harpoon: ' .. filename,
                vim.log.levels.INFO,
                { title = 'Harpoon', filename = filename }
            )
        end)
        vim.keymap.set('n', '<space>e', function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = 'Harpoon = mostrar menú rápido' })

        vim.keymap.set('n', '<space>1', function()
            harpoon:list():select(1)
        end, { desc = 'Harpoon = seleccionar elemento 1' })
        vim.keymap.set('n', '<space>2', function()
            harpoon:list():select(2)
        end, { desc = 'Harpoon = seleccionar elemento 2' })
        vim.keymap.set('n', '<space>3', function()
            harpoon:list():select(3)
        end, { desc = 'Harpoon = seleccionar elemento 3' })
        vim.keymap.set('n', '<space>4', function()
            harpoon:list():select(4)
        end, { desc = 'Harpoon = seleccionar elemento 4' })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set('n', '<space>|', function()
            harpoon:list():prev()
        end, { desc = 'Harpoon = prev' })
        vim.keymap.set('n', '<space>\\', function()
            harpoon:list():next()
        end, { desc = 'Harpoon = next' })
    end,
}
