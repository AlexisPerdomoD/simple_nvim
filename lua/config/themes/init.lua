local vscode = require 'config.themes.vscode'
local dracula = require 'config.themes.dracula'
local vercel = require 'config.themes.vercel'
local vesper = require 'config.themes.vesper'
local everbush = require 'config.themes.everbush'
local zenbones = require 'config.themes.zenbones'
local sora = require 'config.themes.sora'
local themes = {
    vscode,
    dracula,
    vercel,
    vesper,
    everbush,
    zenbones,
    sora,
}

for _, theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
local activetheme = zenbones
activetheme.lazy = false
activetheme.priority = 1000

return themes
