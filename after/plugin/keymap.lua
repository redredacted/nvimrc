local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

vim.keymap.set('n', '<leader>hm', mark.toggle_file, { desc = 'Harpoon Mark'})
vim.keymap.set('n', '<leader>hu', ui.toggle_quick_menu, { desc = 'Harpoon UI'})
vim.keymap.set('n', '<leader>hn', ui.nav_next, { desc = 'Next'})
vim.keymap.set('n', '<leader>hb', ui.nav_prev, { desc = 'Prev'})
vim.cmd [[
let g:vimwiki_lists = [{'auto_diary_index': 1}]
]]
