local vscode = require 'config.themes.vscode'
local dracula = require 'config.themes.dracula'
local vercel = require 'config.themes.vercel'
local everbush = require 'config.themes.everbush'
local sora = require 'config.themes.sora'

local themes = {
    vscode,
    dracula,
    vercel,
    everbush,
    sora,
}

for _, theme in ipairs(themes) do
    theme.lazy = true
end

-- ACTIVE THEME
-- local activetheme = vscode
-- activetheme.lazy = false
-- activetheme.priority = 1000

return themes
