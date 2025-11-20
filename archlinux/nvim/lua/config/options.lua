-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_picker = "fzf"

vim.g.mapleader = " "

vim.opt.encoding = "utf-8"

vim.opt.compatible = false
vim.opt.hlsearch = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.vb = true
vim.opt.ruler = true
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.autoindent = true
vim.opt.colorcolumn = "120"
vim.opt.textwidth = 120
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"
vim.opt.scrollbind = false
vim.opt.wildmenu = true
-- wrap long line
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2"

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3

-- filetype related
vim.api.nvim_create_autocmd("FileType", {
   pattern = { "gitcommit" },
   callback = function(ev)
      vim.api.nvim_set_option_value("textwidth", 72, { scope = "local" })
   end,
})

vim.api.nvim_create_autocmd("FileType", {
   pattern = { "markdown" },
   callback = function(ev)
      vim.api.nvim_set_option_value("textwidth", 0, { scope = "local" })
      vim.api.nvim_set_option_value("wrapmargin", 0, { scope = "local" })
      vim.api.nvim_set_option_value("linebreak", true, { scope = "local" })
   end,
})
