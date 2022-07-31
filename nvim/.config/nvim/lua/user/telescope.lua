require('telescope').setup {
  defaults = {
    file_ignore_patterns = {".git/", "node_modules"},
    previewer = true,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

require('telescope').load_extension('fzf')
