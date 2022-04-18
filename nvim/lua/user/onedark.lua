require('onedark').setup {
    style = 'dark',
    transparent = true,
    highlights = {
        TSField = {fg = '$fg'},
        TSFuncBuiltin = {fg = '$red'},
        TSKeywordReturn = {fg = '$red'},
        TSOperator = {fg = '$cyan'},
        TSParameter = {fg = '$fg'},
        TSProperty = {fg = '$fg'},
        TSPunctBracket = {fg = '$light_grey'},
        TSPunctDelimiter = {fg = '$purple'},
        TSPunctSpecial = {fg = '$red'},
        TSTag = {fg = '$yellow'},
        TSTagAttribute = {fg = '$orange'},
        TSTagDelimiter = {fg = '$light_grey'},
        luaTSConstructor = {fg = '$light_grey'},
        GitSignsChange = {fg = '$yellow'},
    },
}

require('onedark').load()
