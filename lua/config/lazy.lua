-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")

vim.keymap.set("n", "<leader>e", "ié")

-- Fterm keymaps
vim.keymap.set("n", "<A-i>", function() require("FTerm").toggle() end)
vim.keymap.set("t", "<A-i>", function() require("FTerm").toggle() end)
vim.keymap.set("t", "<A-k>", function() require("FTerm").close() end)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" };
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})

-- Salva referência do handler original
local orig_rename = vim.lsp.handlers["textDocument/rename"]

-- Substitui o handler com a lógica extra
vim.lsp.handlers["textDocument/rename"] = function(err, result, ctx, config)
  -- Chama o handler original
  orig_rename(err, result, ctx, config)

  -- Aguarda um pouco e salva todos os buffers
  vim.defer_fn(function()
    vim.cmd("wall")  -- ou use :wa
  end, 50)
end
--   vim.cmd [[
--   augroup jdtls_lsp
--      autocmd!
--      autocmd FileType java lua require'ghd8.jdtls_setup'.setup()
--      autocmd BufNewFile *.java lua require'ghd8.javautils'.insertJavaTemplate()
--   augroup end
--   ]]



-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "modus" } },
  -- automatically check for plugin updates
--  checker = { enabled = true },
})

