local function nmap(lhs, rhs)
  vim.api.nvim_set_keymap("n", lhs, rhs, { noremap = true, silent = true })
end

nmap("K", "<cmd>Lspsaga hover_doc<cr>")
nmap(",", "<cmd>Lspsaga preview_definition<cr>")
nmap(";", "<cmd>Lspsaga code_action<cr>")
nmap("\\", "<cmd>Lspsaga lsp_finder<cr>")
nmap("<c-j>", "<cmd>Lspsaga diagnostic_jump_next<cr>")
nmap("<c-k>", "<cmd>Lspsaga diagnostic_jump_prev<cr>")
nmap("<c-b>", "<cmd>lua vim.lsp.buf.definition()<cr>")

vim.g.mapleader = " "

local wk = require("which-key")
wk.setup()

local leader = {
  p = {
    name = "+project",
    f = {"<cmd>Telescope find_files<cr>", "find files"},
    g = {"<cmd>Telescope git_files<cr>", "git files"},
  },
  b = {
    name = "+buffers",
    b = { "<cmd>Telescope buffers<cr>", "list" }
  },
  g = {
    name = "+git",
    c = { [[<cmd>lua require("telescope.builtin").git_commits()<cr>]], "commits"},
    b = { [[<cmd>lua require("telescope.builtin").git_branches()<cr>]], "branches"},
    s = { [[<cmd>lua require("telescope.builtin").git_status()<cr>]], "status"},
    t = { [[<cmd>lua require("telescope.builtin").git_stash()<cr>]], "stash"},
    f = { [[<cmd>lua require("telescope.builtin").git_bcommits()<cr>]], "file commits"},
  },
  c = {
    name = "+code",
    r = { [[<cmd>lua require("telescope.builtin").lsp_references()<cr>]], "references" },
    a = { [[<cmd>lua require("telescope.builtin").lsp_code_actions()<cr>]], "actions" },
    s = { [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>]], "document symbols" },
    w = { [[<cmd>lua require("telescope.builtin").lsp_workspace_symbols()<cr>]], "workspace symbols" },
    i = { [[<cmd>lua require("telescope.builtin").lsp_implementations()<cr>]], "implementation" },
    t = { [[<cmd>lua require("telescope.builtin").lsp_type_definitions()<cr>]], "type definitions" },
    d = { [[<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<cr>]], "document diagnostics" },
    p = { [[<cmd>lua require("telescope.builtin").lsp_workspace_diagnostics()<cr>]], "workspace diagnostics" },
  },
  r = {
    name = "+refactor",
    r = { "<cmd>Lspsaga rename<cr>", "rename" }
  },
  t = {
    name = "+toggle",
    f = { "<cmd>NvimTreeToggle<cr>", "tree" },
    n = { "<cmd>set number!<cr>", "line numbers" },
    h = { [[<cmd>lua require("config.inlay").toggle_inlay_hints()<cr>]], "inlay hints" },
    s = { [[<cmd>lua require("shade").toggle()<cr>]], "shade" },
    o = { "<cmd>SymbolsOutline<cr>", "outline"}
  },
  v = {
    name = "+vim",
    r = { [[<cmd>lua require("telescope.builtin").registers()<cr>]], "registers" },
    m = { [[<cmd>lua require("telescope.builtin").marks()<cr>]], "marks" },
    j = { [[<cmd>lua require("telescope.builtin").jumplist()<cr>]], "jumplist" },
    c = { [[<cmd>lua require("telescope.builtin").commands()<cr>]], "commands" },
    h = { [[<cmd>lua require("telescope.builtin").commands_history()cr>]], "commands history" },
    s = { [[<cmd>lua require("telescope.builtin").search_history()<cr>]], "search history" },
    k = { [[<cmd>lua require("telescope.builtin").keymaps()<cr>]], "keymaps" },
    p = {[[<cmd>lua require("telescope.builtin").pickers()<cr>]], "pickers"},
  },
  m = {
    name = "+mgmt",
    r = {"<cmd>luafile %<cr>", "reload config"},
    u = {"<cmd>PackerSync<cr>", "packer sync"},
    c = { "<cmd>PackerCompile<cr>", "packer compile" },
  },
  s = {
    p = {"<cmd>Telescope live_grep<cr>", "search project"},
    c = {"<cmd>noh<cr>", "clear search"},
    l = {[[<cmd>lua require("telescope.builtin").resume()<cr>]], "previous"},
  },
  x = {
    t = {"<cmd>TroubleToggle<cr>", "toggle trouble"},
    w = {"<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace trouble"},
    d = {"<cmd>TroubleToggle document_diagnostics<cr>", "document trouble"},
    r = {"<cmd>TroubleRefresh<cr>", "refresh trouble"},
  }
}

wk.register(leader, { prefix = "<leader>" })
