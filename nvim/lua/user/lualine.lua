require('lualine').setup {
    options = {
        theme = 'gruvbox',
        section_separators= { left = '', right = ''},
        component_separators = { left = '', right = ''},
    },
    sections = {
        lualine_a = {},
        lualine_b = {'branch'},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {'filetype', 'encoding'},
        lualine_y = {'location'},
        lualine_z = {}
    }
}
