-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

-- Cursor shapes: blinking beam in insert, block in normal/visual
-- blinkon/blinkoff in ms, blinkwait=1 means blink starts immediately
vim.opt.guicursor = "n-c:block,v:block,i-ci-ve:ver25-blinkon500-blinkoff300-blinkwait1,r-cr:hor20,o:hor50"
