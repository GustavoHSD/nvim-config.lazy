return {
  'babidiii/rust-cfg.nvim',
  -- For lazy.nvim, the standard key is `dependencies`
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
    'simrat39/rust-tools.nvim',
  },
  -- Define keys here to enable lazy-loading
  keys = {
    { "<leader>cf", "<cmd>Telescope rust_cfg features<CR>", desc = "Rust Cfg [F]eatures" },
    { "<leader>ct", "<cmd>Telescope rust_cfg targets<CR>", desc = "Rust Cfg [T]argets" },
  },
  -- The config function is now simpler
  config = function()
    -- The extension still needs to be loaded when the plugin is configured
    require('telescope').load_extension('rust_cfg')
  end,
}
