require("nvim-web-devicons").setup({
    -- Global settings
    color_icons = true,
    default = true,
    strict = true,
    variant = "auto", -- Auto-detect based on background

    -- Custom icon overrides for specific files
    override = {
        zsh = {
            icon = "",
            color = "#428850",
            cterm_color = "65",
            name = "Zsh"
        },
        lua = {
            icon = "",
            color = "#51a0cf",
            cterm_color = "74",
            name = "Lua"
        },
        vim = {
            icon = "",
            color = "#019833",
            cterm_color = "28",
            name = "Vim"
        },
        dockerfile = {
            icon = "󰡨",
            color = "#458ee6",
            cterm_color = "68",
            name = "Dockerfile"
        },
        json = {
            icon = "",
            color = "#cbcb41",
            cterm_color = "185",
            name = "Json"
        },
        yaml = {
            icon = "",
            color = "#fbc02d",
            cterm_color = "220",
            name = "Yaml"
        },
        toml = {
            icon = "",
            color = "#9c4221",
            cterm_color = "166",
            name = "Toml"
        },
        md = {
            icon = "",
            color = "#519aba",
            cterm_color = "67",
            name = "Markdown"
        },
        py = {
            icon = "",
            color = "#ffbc03",
            cterm_color = "214",
            name = "Python"
        },
        js = {
            icon = "",
            color = "#cbcb41",
            cterm_color = "185",
            name = "JavaScript"
        },
        ts = {
            icon = "",
            color = "#519aba",
            cterm_color = "67",
            name = "TypeScript"
        },
        tsx = {
            icon = "",
            color = "#1354bf",
            cterm_color = "26",
            name = "TypeScriptReact"
        },
        jsx = {
            icon = "",
            color = "#20c2e3",
            cterm_color = "45",
            name = "JavaScriptReact"
        },
        go = {
            icon = "",
            color = "#519aba",
            cterm_color = "67",
            name = "Go"
        },
        rust = {
            icon = "",
            color = "#dea584",
            cterm_color = "216",
            name = "Rust"
        },
        c = {
            icon = "",
            color = "#599eff",
            cterm_color = "111",
            name = "C"
        },
        cpp = {
            icon = "",
            color = "#f34b7d",
            cterm_color = "204",
            name = "CPlusPlus"
        }
    },

    -- Filename-specific overrides
    override_by_filename = {
        [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore"
        },
        [".gitmodules"] = {
            icon = "",
            color = "#f1502f",
            name = "GitModules"
        },
        [".gitattributes"] = {
            icon = "",
            color = "#f1502f",
            name = "GitAttributes"
        },
        ["package.json"] = {
            icon = "",
            color = "#e8274b",
            name = "PackageJson"
        },
        ["package-lock.json"] = {
            icon = "",
            color = "#7a2048",
            name = "PackageLockJson"
        },
        ["tsconfig.json"] = {
            icon = "",
            color = "#519aba",
            name = "TsConfig"
        },
        ["webpack.config.js"] = {
            icon = "󰜫",
            color = "#519aba",
            name = "Webpack"
        },
        [".eslintrc.js"] = {
            icon = "󰱺",
            color = "#4b32c3",
            name = "EslintConfig"
        },
        [".prettierrc"] = {
            icon = "",
            color = "#f7ba3e",
            name = "PrettierConfig"
        },
        ["Dockerfile"] = {
            icon = "󰡨",
            color = "#458ee6",
            name = "Dockerfile"
        },
        ["docker-compose.yml"] = {
            icon = "󰡨",
            color = "#458ee6",
            name = "DockerCompose"
        },
        ["Makefile"] = {
            icon = "",
            color = "#427819",
            name = "Makefile"
        },
        ["README.md"] = {
            icon = "",
            color = "#519aba",
            name = "Readme"
        },
        ["LICENSE"] = {
            icon = "",
            color = "#d0bf41",
            name = "License"
        },
        [".env"] = {
            icon = "",
            color = "#faf743",
            name = "Environment"
        },
        [".env.local"] = {
            icon = "",
            color = "#faf743",
            name = "EnvironmentLocal"
        },
        ["init.lua"] = {
            icon = "",
            color = "#51a0cf",
            name = "LuaInit"
        },
        ["lazy-lock.json"] = {
            icon = "󰒲",
            color = "#7c3aed",
            name = "LazyLock"
        }
    },

    -- Extension-specific overrides
    override_by_extension = {
        ["log"] = {
            icon = "",
            color = "#81e043",
            name = "Log"
        },
        ["txt"] = {
            icon = "",
            color = "#89e051",
            name = "Text"
        },
        ["pdf"] = {
            icon = "",
            color = "#b30b00",
            name = "Pdf"
        },
        ["zip"] = {
            icon = "",
            color = "#fd971f",
            name = "Zip"
        },
        ["tar"] = {
            icon = "",
            color = "#fd971f",
            name = "Tar"
        },
        ["gz"] = {
            icon = "",
            color = "#fd971f",
            name = "Gzip"
        },
        ["mp4"] = {
            icon = "",
            color = "#fd971f",
            name = "Mp4"
        },
        ["mp3"] = {
            icon = "",
            color = "#d39ede",
            name = "Mp3"
        },
        ["wav"] = {
            icon = "",
            color = "#d39ede",
            name = "Wav"
        },
        ["png"] = {
            icon = "",
            color = "#d39ede",
            name = "Png"
        },
        ["jpg"] = {
            icon = "",
            color = "#d39ede",
            name = "Jpg"
        },
        ["jpeg"] = {
            icon = "",
            color = "#d39ede",
            name = "Jpeg"
        },
        ["gif"] = {
            icon = "",
            color = "#d39ede",
            name = "Gif"
        },
        ["svg"] = {
            icon = "󰜡",
            color = "#ffb13b",
            name = "Svg"
        },
        ["ico"] = {
            icon = "",
            color = "#cbcb41",
            name = "Ico"
        },
        ["conf"] = {
            icon = "",
            color = "#6d8086",
            name = "Conf"
        },
        ["cfg"] = {
            icon = "",
            color = "#6d8086",
            name = "Config"
        },
        ["ini"] = {
            icon = "",
            color = "#6d8086",
            name = "Ini"
        }
    },

    -- Operating system specific overrides
    override_by_operating_system = {
        ["apple"] = {
            icon = "",
            color = "#A2AAAD",
            cterm_color = "248",
            name = "Apple",
        },
        ["linux"] = {
            icon = "",
            color = "#fbc02d",
            cterm_color = "220",
            name = "Linux",
        },
        ["windows"] = {
            icon = "",
            color = "#00A4EF",
            cterm_color = "33",
            name = "Windows",
        }
    }
})
