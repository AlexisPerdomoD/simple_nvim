-- =========================
-- UI
-- =========================

vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = false -- Disable relative line numbers
vim.opt.mouse = 'a' -- Enable mouse support in all modes
vim.opt.showcmd = false -- Hide partial commands and pending operators
vim.o.cmdheight = 0 -- Hide the command line when not in use
vim.opt.shortmess:append 'c' -- Reduce messages during completion

-- =========================
-- Cursor and line highlighting
-- =========================

vim.opt.cursorline = true -- Highlight the current line
vim.opt.showmatch = true -- Briefly highlight matching brackets
vim.o.guicursor =
    'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
-- Define cursor shape and blinking behavior for each mode

-- =========================
-- Indentation and line wrapping
-- =========================

vim.opt.breakindent = true -- Preserve indentation on wrapped lines
vim.opt.autoindent = true -- Copy indentation from the previous line
vim.opt.linebreak = true -- Wrap lines at convenient break points

vim.opt.tabstop = 4 -- Number of screen columns occupied by a tab
vim.opt.shiftwidth = 4 -- Number of spaces used for each indentation level
vim.opt.expandtab = true -- Use spaces instead of tab characters

-- =========================
-- Search
-- =========================

vim.opt.hlsearch = true -- Highlight all matches of the last search
vim.opt.incsearch = true -- Show matches while typing a search pattern
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Match case if the pattern contains uppercase letters

-- =========================
-- Clipboard
-- =========================

vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard for default registers

-- =========================
-- Folding
-- =========================

vim.o.foldlevel = 99 -- Set the default fold level to keep most folds open
vim.o.foldenable = true -- Enable folding

-- =========================
-- Spelling
-- =========================

vim.opt.spell = false -- Disable spell checking by default
vim.opt.spelllang = { 'en', 'es' } -- Languages used by spell checking

-- =========================
-- Files and persistence
-- =========================

vim.o.signcolumn = 'yes' -- Always reserve space for diagnostic signs
vim.o.swapfile = false -- Disable swap files
vim.o.undofile = true -- Persist undo history across sessions
vim.opt.autoread = true -- Reload files changed outside Neovim

-- =========================
-- Messages and status
-- =========================

vim.opt.showmode = false -- Hide the mode indicator (e.g. -- INSERT --)
vim.o.lazyredraw = false -- Do not defer screen redraws during macros or scripts

-- =========================
-- Providers
-- =========================

vim.g.loaded_node_provider = 0 -- Disable the Node.js provider
vim.g.loaded_python3_provider = 0 -- Disable the Python 3 provider
vim.g.loaded_ruby_provider = 0 -- Disable the Ruby provider
vim.g.loaded_perl_provider = 0 -- Disable the Perl provider

-- =========================
-- Diagnostics
-- =========================

vim.diagnostic.config {
    severity_sort = true, -- Sort diagnostics by severity
    update_in_insert = false, -- Do not update diagnostics while typing
    virtual_text = true, -- Show diagnostic messages inline
    signs = true, -- Show diagnostic signs in the sign column
    float = { border = 'rounded' }, -- Use rounded borders for diagnostic floats
}

-- =========================
-- Native completion
-- =========================

vim.o.autocomplete = true -- Enable automatic completion
vim.o.complete = 'o' -- Use the specified sources for insert-mode completion
vim.o.completeopt = 'menuone,noselect,noinsert' -- Configure completion menu behavior
vim.o.pumheight = 12 -- Maximum number of visible completion items
vim.o.pumblend = 6 -- Set completion popup transparency
vim.o.pumborder = 'rounded' -- Use rounded borders for the completion popup
vim.o.winborder = 'rounded' -- Default border style for floating windows

-- =========================
-- Command-line completion
-- =========================

vim.o.wildmenu = true -- Enable command-line completion menu
vim.o.wildmode = 'full' -- Show all matches and complete the longest common prefix
vim.o.wildoptions = 'pum' -- Display command-line completion in a popup menu
vim.o.wildignorecase = true -- Ignore case when completing command-line entries
vim.o.wildcharm = 9 -- Character used to trigger command-line completion in mappings
