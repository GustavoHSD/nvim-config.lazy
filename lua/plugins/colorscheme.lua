return {
--  {
--    "miikanissi/modus-themes.nvim",
--    priority = 1000,
--    lazy = false,
--    config = function()
--      vim.cmd([[colorscheme modus]])
--    end,
--  },
  { 'projekt0n/github-nvim-theme', name = 'github-theme',
    config = function() 
      vim.cmd([[colorscheme github_dark_high_contrast]])
    end,
  }
-- {
--   "rebelot/kanagawa.nvim",
--   priority = 1000,
--   lazy = false,
--   config = function()
--     vim.cmd([[colorscheme kanagawa-dragon]])
--   end,
-- }
}


