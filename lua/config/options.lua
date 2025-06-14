-- eliminar linter de error con variable vim
-- Mostrar números de línea
vim.opt.number = true
-- Habilitar el uso del mouse
vim.opt.mouse = "a"
-- Mostrar comandos en la barra de estado
vim.opt.showcmd = true

-- Resaltar coincidencias al buscar
vim.opt.showmatch = true

-- Mostrar números de línea relativos
vim.opt.relativenumber = false

-- Configuraciones para la indexación, tabulaciones y formateo de texto para pantallas angostas
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.linebreak = true

-- Habilitar sintaxis y configuración de archivos
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Configuración de indentación predeterminada para todos los archivos
vim.opt.tabstop = 4 -- Número de espacios por tabulación
vim.opt.shiftwidth = 4 -- Número de espacios para indentación
vim.opt.expandtab = true -- Utilizar espacios en lugar de tabulaciones

-- No mostrar el modo de edición
vim.opt.showmode = false

-- Siempre mostrar la barra de estado
vim.opt.laststatus = 2

-- Habilitar colores verdaderos en la terminal
vim.opt.termguicolors = true

-- Configuración de la altura del comando
vim.opt.cmdheight = 0

-- Configuraciones de búsqueda
vim.opt.hlsearch = true -- Resaltar coincidencias
vim.opt.incsearch = true -- Búsqueda incremental
vim.opt.ignorecase = true -- Búsquedas insensibles a mayúsculas...
vim.opt.smartcase = true -- ... A menos que contengan al menos una letra mayúscula

-- Configuración del porta papeles (pendiente de verificación)
vim.opt.clipboard = "unnamedplus"

-- Configuración de plegado
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true
-- Usa el portapapeles del sistema para copiar y pegar
---@diagnostic disable: undefined-field
vim.opt.spell = true
vim.opt.spelllang = { "en", "es" }
vim.o.signcolumn = "yes"

-- warnings disabled
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_lua_provider = 0
