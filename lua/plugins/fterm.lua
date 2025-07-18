return {
  "numToStr/FTerm.nvim",
  contig = function()
    require'FTerm'.setup({
      border = 'double',
      dimensions  = {
        height = 0.9,
        width = 0.9,
      },
    })
  end
}
