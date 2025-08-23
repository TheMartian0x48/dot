-- File type associations and customizations

-- Set filetype for C++ and C
vim.filetype.add {
    extension = {
        cpp = "cpp",
        cmm = "cpp",
        cxx = "cpp",
        cc = "cpp",
        hpp = "cpp",
        hxx = "cpp",
        hh = "cpp",
        c = "c",
        h = "c",
        zig = "zig", 
    },
    pattern = {
        [".*%.ino"] = "cpp",
    },
}
