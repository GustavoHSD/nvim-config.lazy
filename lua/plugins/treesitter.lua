return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0,
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "java", "python", "typescript", "tsx", "rust", "css", "scss", "html" },
        sync_install = false,
        auto_install = true,
        require'nvim-ts-autotag'.setup(),
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
  }
}
