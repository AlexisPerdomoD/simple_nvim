local catppuccin = require 'config.themes.catppuccin'
local dracula = require 'config.themes.dracula'
local vscode = require 'config.themes.vscode'
local github = require 'config.themes.github'
local solarizedosaka = require 'config.themes.solarizedosaka'
local moonfly = require 'config.themes.moonfly'
local monochrome = require 'config.themes.monochrome'
local bamboo = require 'config.themes.bamboo'
local onedark = require 'config.themes.onedark'

local themes = {
    catppuccin,
    dracula,
    vscode,
    github,
    solarizedosaka,
    moonfly,
    monochrome,
    bamboo,
    onedark,
}

for _, theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme = vscode
activetheme.lazy = false
activetheme.priority = 1000

return themes
