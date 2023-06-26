-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function nmap(lhs, rhs, desc)
  vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
end

function Toggle_inlay_hints()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  if ft == "rust" then
    -- rust tools removed inlay hints for some reason
    -- require("rust-tools.inlay_hints").toggle_inlay_hints()
  elseif ft == "typescript" then
    require("nvim-lsp-ts-utils").toggle_inlay_hints()
  else
    print("No inlay hints for", ft)
  end
end

-- navigate
nmap("gt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>", "Go To Type Definition")
nmap("gn", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Go To Next Diagnostic")
nmap("gp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Go To Prev Diagnostic")

-- search
nmap("<leader>sc", "<cmd>noh<cr>", "Clear search")
nmap("<leader>S", "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep (cwd)")

-- files
nmap("<leader>F", "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files (cwd)")

-- toggles
nmap("<leader>ti", "<cmd>lua Toggle_inlay_hints()<cr>", "Toggle Inlay Hints")
nmap("<leader>tn", "<cmd>set number!<cr>", "Toggle Line Numbers")
-- todo: indent guides

nmap("<C-w>z", ":TZFocus<CR>", "Zoom Window")
nmap("<leader>wz", ":TZFocus<CR>", "Zoom Window")
