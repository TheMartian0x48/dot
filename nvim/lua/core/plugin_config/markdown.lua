require('md-pdf').setup({
ignore_viewer_state = true
})

-- setup mapping
vim.keymap.set("n", "<Space>,", function()
    require('md-pdf').convert_md_to_pdf()
end)
