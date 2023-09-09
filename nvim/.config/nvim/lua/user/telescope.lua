local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.load_extension('fzf')
telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<Esc>'] = actions.close
            }
        }
    }
}

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files'})
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Git files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc='Grep files'})
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

