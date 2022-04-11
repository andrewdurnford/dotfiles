require('onedark').setup {
    style = 'dark',
    transparent = true,
    code_style = {
        comments = 'none',
    },
    highlights = {
        TSField = {fg = '$fg'},
        TSFuncBuiltin = {fg = '$red'},
        TSKeywordReturn = {fg = '$red'},
        TSOperator = {fg = '$cyan'},
        TSParameter = {fg = '$fg'},
        TSProperty = {fg = '$fg'},
        TSPunctDelimiter = {fg = '$purple'},
        TSPunctBracket = {fg = '$light_grey'},
        TSPunctSpecial = {fg = '$red'},
        TSTag = {fg = '$yellow'},
        TSTagAttribute = {fg = '$orange'},
        TSTagDelimiter = {fg = '$light_grey'},
        luaTSConstructor = {fg = '$light_grey'},
        GitSignsChange = {fg = '$yellow'},
    },
}

require('onedark').load()
