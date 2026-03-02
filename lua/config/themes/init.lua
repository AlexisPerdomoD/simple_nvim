local catppuccin = require 'config.themes.catppuccin'
local dracula = require 'config.themes.dracula'
local vscode = require 'config.themes.vscode'
local github = require 'config.themes.github'
local solarizedosaka = require 'config.themes.solarizedosaka'
local monochrome = require 'config.themes.monochrome'
local bamboo = require 'config.themes.bamboo'
local matrix = require 'config.themes.matrix'
local vague = require 'config.themes.vague'
local themes = {
    catppuccin,
    dracula,
    vscode,
    github,
    solarizedosaka,
    monochrome,
    bamboo,
    matrix,
    vague,
}

for _, theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme = vague
activetheme.lazy = false
activetheme.priority = 1000

return themes
