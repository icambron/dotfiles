local telescope = require("telescope");
local actions = require("telescope.actions");

telescope.setup {
  defaults = {
    mappings = {
      i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
			},
    },
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}
telescope.load_extension("fzf")
telescope.load_extension("ui-select")
