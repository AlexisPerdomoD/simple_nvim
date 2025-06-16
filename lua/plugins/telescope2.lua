local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function change_neovide_font()
    if vim.g.neovide == nil then
        print("Nerd font only posible to change on neovide for now")
        return true
    end
    local fonts = {}
    -- lee las fuentes instaladas
    for font in io.popen("fc-list : family | sort | uniq"):lines() do
        table.insert(fonts, font)
    end

    pickers
        .new({}, {
            prompt_title = "Select Neovide Font",
            finder = finders.new_table({
                results = fonts,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(buff, _)
                actions.select_default:replace(function()
                    actions.close(buff)
                    local selection = action_state.get_selected_entry()
                    -- cambia la fuente de Neovide dinámicamente
                    vim.o.guifont = selection[1]
                    print("Neovide font set to: " .. selection[1])
                end)
                return true
            end,
        })
        :find()
end

return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    },
    opts = {
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    },
    config = function(opts)
        require("telescope").setup(opts)
        -- require('telescope').load_extension('fzf')
    end,
    keys = {
        {
            "<space>cb",
            function() require("telescope.builtin").buffers() end,
            desc = "Telescope buffers",
        },
        {
            "<space>gs",
            function() require("telescope.builtin").git_status() end,
            desc = "Telescope Git status",
        },
        {
            "<space>gf",
            function() require("telescope.builtin").git_files({ show_untracked = true }) end,
            desc = "Telescope Git Files",
        },
        {
            "<space>gc",
            function() require("telescope.builtin").git_commits() end,
            desc = "Telescope Git commits",
        },
        {
            "<space>gb",
            function() require("telescope.builtin").git_branches() end,
            desc = "Telescope Git branches",
        },
        {
            "<space>pp",
            function()
                require("telescope.builtin").find_files({
                    prompt_title = "Plugins",
                    cwd = vim.fn.stdpath("config") .. "/lua/plugins",
                    attach_mappings = function(_, map)
                        map("i", "<c-y>", function(prompt_bufnr)
                            local new_plugin = action_state.get_current_line()
                            actions.close(prompt_bufnr)
                            vim.cmd(
                                string.format("edit ~/.config/nvim/lua/plugins/%s.lua", new_plugin)
                            )
                        end)
                        return true
                    end,
                })
            end,
        },
        {
            "<space>ff",
            function() require("telescope.builtin").find_files() end,
            desc = "Telescope Find Files",
        },
        {
            "<space>h",
            function() require("telescope.builtin").help_tags() end,
            desc = "Telescope Help",
        },
        {
            "<space>fb",
            function()
                require("telescope").extensions.file_browser.file_browser({
                    path = "%:h:p",
                    select_buffer = true,
                })
            end,
            desc = "Telescope file browser",
        },
        {
            "<space>C",
            function() require("telescope.builtin").colorscheme() end,
            desc = "ColorScheme Telescope",
        },
        {
            "<space>hk",
            function() require("telescope.builtin").keymaps() end,
            desc = "Telescope keymaps",
        },
        {
            "<space>SS",
            function()
                require("telescope.builtin").grep_string({
                    use_regex = true,
                    word_match = "-w",
                })
            end,
            desc = "Telescope grep string",
        },
        {
            "<space>ss",
            function() require("telescope.builtin").live_grep() end,
            desc = "Telescope live_grep",
        },
        { "<space>nf", change_neovide_font, desc = "cambiar nerdfont" },
    },
}
