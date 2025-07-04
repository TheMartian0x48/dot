-- UI and visual plugins
return {
    -- Colorschemes
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
    },
    {
        "kepano/flexoki-neovim",
        name = 'flexoki',
        priority = 1000,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("plugins.ui.colorscheme")
        end,
    },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        config = function()
            require("plugins.ui.icon")
        end,
    },

    -- Status line
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require("plugins.ui.statusline")
        end,
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("plugins.ui.ntree")
        end,
    },
}
