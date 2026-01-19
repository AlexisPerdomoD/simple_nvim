local catppuccin     = require 'config.themes.catppuccin'
local dracula        = require 'config.themes.dracula'
local material       = require 'config.themes.material'
local vscode         = require 'config.themes.vscode'
local github         = require 'config.themes.github'
local edge           = require 'config.themes.edge'
local lackluster     = require 'config.themes.lackcluster'
local solarizedosaka = require 'config.themes.solarizedosaka'
local moonfly        = require 'config.themes.moonfly'

local themes         = {
    catppuccin,
    dracula,
    material,
    vscode,
    github,
    edge,
    lackluster,
    solarizedosaka,
    moonfly
}

for _, theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme    = solarizedosaka
activetheme.lazy     = false
activetheme.priority = 1000
return themes
