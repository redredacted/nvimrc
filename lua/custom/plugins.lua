return function(use)
  use({
    "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
      end
  })
  use('nvim-treesitter/playground')
  use('simrat39/rust-tools.nvim')
  use('xiyaowong/nvim-transparent')
  use('ThePrimeagen/harpoon')
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}
end
