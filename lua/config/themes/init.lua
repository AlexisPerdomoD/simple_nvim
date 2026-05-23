local catppuccin    = require 'config.themes.catppuccin'
local vscode        = require 'config.themes.vscode'
local matrix        = require 'config.themes.matrix'
local vague         = require 'config.themes.vague'
local dracula       = require 'config.themes.dracula'
local vercel        = require 'config.themes.vercel'
local vesper        = require 'config.themes.vesper'
local ayu           = require 'config.themes.ayu'
local boo           = require 'config.themes.boo'
local themes = {
    catppuccin,
    vscode,
    matrix,
    vague,
    dracula,
    vercel,
    vesper,
    ayu,
    boo,
}

for _ , theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme       = boo
activetheme.lazy        = false
activetheme.priority    = 1000

return themes
