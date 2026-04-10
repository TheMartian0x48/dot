return {
    -- Smart comments
    {
        "numToStr/Comment.nvim",
        version = "v0.8.0",
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },

    -- Highlight TODO, FIXME, etc
    {
        "folke/todo-comments.nvim",
        version = "v1.5.0",
        dependencies = { { "nvim-lua/plenary.nvim", commit = "b9fd522" } },
        event = { "BufReadPost", "BufNewFile" },
        opts = {},
    },
}
