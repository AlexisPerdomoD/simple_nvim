local catppuccin    = require 'config.themes.catppuccin'
local vscode        = require 'config.themes.vscode'
local github        = require 'config.themes.github'
local matrix        = require 'config.themes.matrix'
local vague         = require 'config.themes.vague'
local nightjungle   = require 'config.themes.nightjungle'
local themes = {
    catppuccin,
    vscode,
    github,
    matrix,
    vague,
    nightjungle,
}

for _ , theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme       = vague
activetheme.lazy        = false
activetheme.priority    = 1000
return themes
