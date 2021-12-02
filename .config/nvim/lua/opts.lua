-- basics
vim.opt.swapfile = false
vim.opt.hidden = true -- allow background buffers

-- display
vim.opt.termguicolors = true

-- undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. '/undo'

-- search
vim.opt.hlsearch = true          -- Highlight matches
vim.opt.incsearch = true         -- Incremental searching
vim.opt.ignorecase = true        -- Searches are case insensitive...
vim.opt.smartcase = true         -- ...Unless they contain at least one capital letter

-- tabs
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
-- vim.opt.smartindent = true
vim.opt.shiftround = true

-- other editing
vim.opt.updatetime = 300

vim.opt.whichwrap= "b,s,h,l,<,>,[,]"   -- Backspace and cursor keys wrap too

-- invisible chars
vim.opt.list = true
vim.opt.listchars = { tab = " ", trail = "·" }

-- completion
vim.opt.completeopt= "menuone,noinsert,noselect"
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full" -- Command <Tab> completion, list matches, then longest common part, then all.
vim.opt.wildignore = "*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.swp,*~,._*"

-- misc
vim.opt.clipboard = "unnamedplus"
vim.opt.shortmess = "flxoOtTc"
vim.opt.signcolumn = "yes:1"

