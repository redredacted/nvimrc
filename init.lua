local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", --latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
	"folke/which-key.nvim",
	"folke/neodev.nvim",
	"folke/tokyonight.nvim",
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.api.nvim_command, "MasonUpdate")
				end,
			},
			"williamboman/mason-lspconfig.nvim",

			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 1000
		end,
		opts = {}
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
				build = function()
					pcall(vim.api.nvim_command, "TSUpdate")
				end
			}
		}
	},
	"lukas-reineke/indent-blankline.nvim",
	"NMAC427/guess-indent.nvim",
	"numToStr/Comment.nvim",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
      },
      -- "nvim-tree/nvim-web-devicons",
      -- {
      --   "nvim-telescope/telescope-ui-select.nvim",
      --   opts = {}
      -- }
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {}
  },
  {
    "stevearc/dressing.nvim",
    opts = {}
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {}
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim"
    }
  },
  "tpope/vim-fugitive"
})

require("guess-indent").setup({})
-- TODO: setup whichkey for this
require("Comment").setup({})
-- require("telescope").load_extension("ui-select")

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "rust", "typescript", "javascript", "java", "html", "c_sharp", "css",
		"dockerfile", "git_config", "git_rebase", "gitattributes", "gitignore", "go", "gomod", "json", "make",
		"markdown", "nix", "sql", }
})

vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.cmd.colorscheme('tokyonight')

require("neodev").setup({})

local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
	-- :help lsp-zero-keybindings
  -- TODO: setup whichkey for this
	lsp.default_keymaps({ bugger = bufnr })
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.ensure_installed({
	"lua_ls",
})

lsp.setup()
