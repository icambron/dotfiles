local telescope = require("telescope");
local trouble = require("trouble");
telescope.setup {
  defaults = {
    mappings = {
      i = { ["<C-t>"] = trouble.open_with_trouble }, -- these don't work?
      n = { ["<C-t>"] = trouble.open_with_trouble },
    },
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}
telescope.load_extension("fzf")
