local catppuccin    = require 'config.themes.catppuccin'
local vscode        = require 'config.themes.vscode'
local dracula       = require 'config.themes.dracula'
local vercel        = require 'config.themes.vercel'
local vesper        = require 'config.themes.vesper'
local ayu           = require 'config.themes.ayu'
local pallete       = require 'config.themes.pallete'
local poimandres    = require 'config.themes.poimandres'
local everbush      = require 'config.themes.everbush'
local zenbones      = require 'config.themes.zenbones'
local themes = {
    catppuccin,
    vscode,
    dracula,
    vercel,
    vesper,
    ayu,
    pallete,
    poimandres,
    everbush,
    zenbones,
}

for _ , theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme       = poimandres
activetheme.lazy        = false
activetheme.priority    = 1000

return themes
