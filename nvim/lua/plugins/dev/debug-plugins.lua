-- Debugging plugins
return {
    -- Debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            require("plugins.dev.dap")
        end,
        keys = {
            { "<F8>",       function() require("dap").continue() end,          desc = "Debug: Continue" },
            { "<F9>",       function() require("dap").step_over() end,         desc = "Debug: Step Over" },
            { "<F10>",      function() require("dap").step_into() end,         desc = "Debug: Step Into" },
            { "<F11>",      function() require("dap").step_out() end,          desc = "Debug: Step Out" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
            { "<leader>du", function() require("dapui").toggle() end,          desc = "Debug: Toggle UI" },
        },
    },
}
