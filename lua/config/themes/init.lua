local catppuccin = require 'config.themes.catppuccin'
local vscode = require 'config.themes.vscode'
local github = require 'config.themes.github'
local matrix = require 'config.themes.matrix'
local vague = require 'config.themes.vague'
local nightjungle = require 'config.themes.nightjungle'
local doric = require 'config.themes.doric'
local onenord = require 'config.themes.onenord'
local cyberdream = require 'config.themes.cyberdream'
local themes = {
    catppuccin,
    vscode,
    github,
    matrix,
    vague,
    nightjungle,
    doric,
    onenord,
    cyberdream,
}

for _, theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme = cyberdream
activetheme.lazy = false
activetheme.priority = 1000
return themes
