require('telescope').setup {
  defaults = {
    file_ignore_patterns = {".git/*", "node_modules"},
    prompt_position = 'top'
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}

require('telescope').load_extension('fzf')
