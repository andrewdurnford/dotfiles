require('onedark').setup {
    style = 'dark',
    transparent = true,
    highlights = {
        -- TSField = {fg = '$fg'},
        TSFuncBuiltin = {fg = '$red'},
        TSKeywordReturn = {fg = '$red'},
        -- TSOperator = {fg = '$cyan'},
        -- TSParameter = {fg = '$fg'},
        -- TSProperty = {fg = '$fg'},
        -- TSPunctBracket = {fg = '$light_grey'},
        -- TSPunctDelimiter = {fg = '$purple'},
        -- TSPunctSpecial = {fg = '$red'},
        TSTag = {fg = '$red'},
        TSTagAttribute = {fg = '$orange'},
        TSTagDelimiter = {fg = '$light_grey'},
        -- luaTSConstructor = {fg = '$light_grey'},
        GitSignsChange = {fg = '$yellow'},

        -- quake
        TSType = {fg = '$purple'},
        TSTypeBuiltin = {fg = '$purple'},

        TSPunctBracket = {fg = '$fg'},
        TSPunctDelimiter = {fg = '$fg'},
        TSPunctSpecial = {fg = '$fg'},
        TSOperator = {fg = '$fg'},

        TSParameter = {fg = '$yellow'},
        TSField = {fg = '$yellow'},
        TSVariable = {fg = '$yellow'},
        TSProperty = {fg = '$orange'},

        TSBoolean = {fg = '$purple'},
        TSNumber = {fg = '$green'},
        TSConstBuiltin = {fg = '$red'},
        -- TSString = {fg = '$green'},
        TSStringRegex = {fg = '$green'},

        -- misc
        cTSOperator = {fg = '$fg'},
        luaTSConstructor = {fg = '$fg'},

        -- markdown
        markdownTSPunctDelimiter = {fg = '$red'},
        markdownTSPunctSpecial = {fg = '$purple'},

        -- ???

        -- graphqlTSType = {fg = '$yellow'},
        -- graphqlTSParameter = {fg = '$red'},
        -- graphqlTSVariable = {fg = '$red'},
        -- graphqlTSProperty = {fg = '$orange'},

        -- prismaTSType = {fg = '$yellow'},
        -- prismaTSVariable = {fg = '$red'},
    },
}

require('onedark').load()
