local nordic = require 'nordic'
local black = '#171717'

nordic.setup {
    on_palette = function(palette)
        palette.black0 = black
        return palette
    end
}

nordic.load()
