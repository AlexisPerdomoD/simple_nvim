vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showcmd = true
-- Resaltar coincidencias al busca s s
vim.opt.showmatch = true
vim.opt.cursorline = true
-- Configuraciones para la indexación, tabulaciones y formateo de texto para pantallas angostas
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.linebreak = true

-- Habilitar sintaxis y configuración de archivos
-- vim.crd 'syntax on'
-- vim.cmd 'filetype plugin indent on'
-- Configuración de indentación predeterminada para todos los archivos
vim.opt.tabstop = 4 -- Número de espacios por tabulación
vim.opt.shiftwidth = 4 -- Número de espacios para indentación
vim.opt.expandtab = true -- Utilizar espacios en lugar de tabulaciones
vim.o.lazyredraw = true
-- No mostrar el modo de edición
vim.opt.showmode = false
-- Siempre mostrar la barra de estado
vim.opt.laststatus = 0
-- Configuración de la altura del comando
vim.o.cmdheight = 0
-- Configuraciones de búsqueda
vim.opt.hlsearch = true -- Resaltar coincidencias
vim.opt.incsearch = true -- Búsqueda incremental
vim.opt.ignorecase = true -- Búsquedas insensibles a mayúsculas...
vim.opt.smartcase = true -- ... A menos que contengan al menos una letra mayúscula
-- Configuración del porta papeles (pendiente de verificación)
vim.opt.clipboard = 'unnamedplus'
vim.o.guicursor =
    'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
-- Configuración de plegado
vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevel = 99
vim.o.foldenable = true
-- Usa el portapapeles del sistema para copiar y pegar
vim.opt.spell = false
vim.opt.spelllang = { 'en', 'es' }
vim.o.signcolumn = 'yes'
-- chequear
vim.o.swapfile = false
vim.o.undofile = true
vim.opt.autoread = true
-- warnings disabled
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
