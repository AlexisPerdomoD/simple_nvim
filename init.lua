require 'config'

if vim.g.neovide then require('utils.neovide_setup').neovide_setup() end

vim.opt.lazyredraw = false
vim.o.cursorline = true
vim.o.guicursor = table.concat({
    'n-v-c:block', -- Bloque completo en modos normal, visual y de comando
    'i-ci-ve:ver25', -- Cursor vertical en inserción y selectores
    'r-cr:hor20', -- Cursor horizontal más pequeño en reemplazo
    'a:blinkon100', -- Parpadeo para todos los modos
    'sm:block-blinkwait175-blinkon150-blinkoff150', -- Parpadeo especial para modo de sustitución
}, ',')

-- require 'utils.cmp_border_setuper'()
