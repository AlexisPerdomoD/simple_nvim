local catppuccin = require 'config.themes.catppuccin'
local vscode = require 'config.themes.vscode'
local github = require 'config.themes.github'
local matrix = require 'config.themes.matrix'
local vague = require 'config.themes.vague'
local deepspace = require 'config.themes.deepspace'
local nightjungle = require 'config.themes.nightjungle'
local doric = require 'config.themes.doric'
local themes = {
    catppuccin,
    vscode,
    github,
    matrix,
    vague,
    deepspace,
    nightjungle,
    doric,
}

for _, theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme = nightjungle
activetheme.lazy = false
activetheme.priority = 1000
return themes
