require('Comment').setup({
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = 'kcc',
        block = 'kcb',
    },
    opleader = {
        line = 'kc',
        block = 'kb',
    },
    extra = {
        above = 'kcO',
        below = 'kco',
        eol = 'kcA',
    },
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    pre_hook = nil,
    post_hook = nil,
})
