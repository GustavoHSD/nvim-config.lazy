-- Performance optimizations
vim.opt.mmp = 5000  -- Maximum memory pattern
vim.opt.hidden = true  -- Keep buffers open in background
vim.opt.updatetime = 100  -- Faster update time
vim.opt.timeoutlen = 500  -- Faster key sequence timeout
vim.opt.ttimeoutlen = 0  -- No timeout for key codes

-- Disable unnecessary features
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_vimballPlugin = 1

-- Optimize for large files
vim.opt.swapfile = false  -- Disable swap files
vim.opt.backup = false  -- Disable backup files
vim.opt.undofile = true  -- Enable persistent undo

-- Optimize for Rust development
vim.g.rust_recommended_style = 1
vim.g.rust_fold = 1
vim.g.rust_conceal = 1
vim.g.rust_conceal_mod_path = 1
vim.g.rust_conceal_pub = 1

-- Optimize for large projects
vim.opt.path:append("**")  -- Search in all subdirectories
vim.opt.wildignore:append("target/**")  -- Ignore target directory
vim.opt.wildignore:append("**/node_modules/**")  -- Ignore node_modules
vim.opt.wildignore:append("**/dist/**")  -- Ignore dist directories

-- Optimize for better performance
vim.opt.lazyredraw = true  -- Don't redraw while executing macros
vim.opt.ttyfast = true  -- Faster terminal connection
vim.opt.synmaxcol = 200  -- Don't syntax highlight long lines 