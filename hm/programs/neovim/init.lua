require('plugins') -- Packer managed plugins
local opt = vim.opt

-- Misc
opt.backup = false -- Something about saving the file.
opt.writebackup = false -- Something about saving the file.
opt.ttyfast = true -- Speed up scrolling ?
vim.cmd.filetype("plugin indent on")

-- General
opt.cc = "80" -- Ruler position.
-- opt.relativenumber = true
opt.number = true
opt.numberwidth = 6
opt.wrap = false -- Do not wrap lines. Allow long lines to extend as far as the line goes.
opt.ruler = true
opt.cursorline = true -- Highlight cursor line underneath the cursor dadawd dwadawadadawdadadaa.
vim.cmd.syntax("on") -- Syntax highlight enabel
opt.showmode = true -- Shows current mode (Insert, Visual...)
opt.clipboard = "unnamedplus" -- Use System clipboard
opt.scrolloff = 10 -- When scrolling, cursor starts to follow Nth line.
opt.cmdheight = 2 -- CMD is larger.
opt.wildmenu = true
-- There are certain files that we would never want to edit with Vim.
-- Wildmenu will ignore files with these extensions.
opt.wildignore = {
    '*.docx', '*.jpg', '*.png', '*.gif', '*.pdf', '*.pyc', '*.exe', '*.flv',
    '*.img', '*.xlsx'
}

-- Indentation
opt.tabstop = 2 -- Tab is equivalent of 2 spaces.
opt.shiftwidth = 2 -- Related to indenting using << and >>
opt.expandtab = true -- Convert tab to spaces
opt.smarttab = true
opt.autoindent = true
opt.softtabstop = 2

-- Theme
opt.background = "dark"
vim.cmd.colorscheme("gruvbox8")
if vim.env.TERM_PROGRAM == "Apple_Terminal" then
    opt.termguicolors = false -- Apple Terminal does not support this 
else
    opt.termguicolors = true -- Enables 24bit color support (more colors) 
end

-- Splits
opt.splitbelow = true -- Using :split splits below
opt.splitright = true -- Using :vsplit splits to right

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.incsearch = true
opt.hlsearch = false

-- Mouse stuff
opt.mouse = "a" -- Enables mouse in all modes
opt.mousefocus = false
opt.mousescroll = "ver:3,hor:6"
