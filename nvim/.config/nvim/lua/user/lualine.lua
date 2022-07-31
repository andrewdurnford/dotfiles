local tokyonight = require("lualine.themes.tokyonight")

tokyonight.normal.c.bg = '#292e42'
-- tokyonight.inactive.c.bg = '#292e42'

require('lualine').setup {
    options = {
        theme = tokyonight,
        section_separators= { left = '', right = ''},
        component_separators = { left = '', right = ''},
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {'filetype', 'encoding', 'progress', 'location'},
        lualine_y = {},
        lualine_z = {},
    }
}
