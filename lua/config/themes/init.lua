local catppuccin    = require 'config.themes.catppuccin'
local vscode        = require 'config.themes.vscode'
local matrix        = require 'config.themes.matrix'
local vague         = require 'config.themes.vague'
local nightjungle   = require 'config.themes.nightjungle'
local dracula       = require 'config.themes.dracula'
local themes = {
    catppuccin,
    vscode,
    matrix,
    vague,
    nightjungle,
    dracula,
}

for _ , theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme       = catppuccin
activetheme.lazy        = false
activetheme.priority    = 1000

return themes
