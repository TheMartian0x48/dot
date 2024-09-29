-- local ensure_packer = function()
--   local fn = vim.fn
--   local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--   if fn.empty(fn.glob(install_path)) > 0 then
--     fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--     vim.cmd [[packadd packer.nvim]]
--     return true
--   end
--   return false
-- end

-- local packer_bootstrap = ensure_packer()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    checker = { enabled = true },
    -- install = { colorscheme = { "habamax" } },
    spec = {
        {
            "luisiacc/gruvbox-baby",
            "rebelot/kanagawa.nvim",
        },
        {
            "nvim-tree/nvim-web-devicons",
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        },
        {
            "nvim-tree/nvim-tree.lua",
        },
        {
            "nvim-lualine/lualine.nvim",
        },
        {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        {
            "nvim-treesitter/nvim-treesitter",
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
        },
        {
            "numToStr/Comment.nvim",
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
            },
        },
        {
            -- "hrsh7th/vim-vsnip",
            -- "hrsh7th/vim-vsnip-integ",
            -- dependencies = {
            --     "rafamadriz/friendly-snippets",
            --     after = "nvim-cmp",
            -- },
            "L3MON4D3/LuaSnip",
        },
        {
            "nvimtools/none-ls.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        {
            "lewis6991/gitsigns.nvim",
        },
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            dependencies = {
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
            },
        },
    },
})
