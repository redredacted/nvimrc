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

vim.keymap.set("n", "<SPACE>", "<Nop>")
vim.g.mapleader = " "

require("lazy").setup({
  "folke/which-key.nvim",
  "folke/neodev.nvim",
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").load()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      require("which-key").register({
        t = {
          name = "Todo",
          t = { "<cmd>TodoTrouble<cr>", "Trouble" },
        },
      }, {
        prefix = "<leader>",
      })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
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
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(vim.api.nvim_command, "TSUpdate")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  "lukas-reineke/indent-blankline.nvim",
  "NMAC427/guess-indent.nvim",
  "numToStr/Comment.nvim",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-tree/nvim-web-devicons",
      -- {
      --   "nvim-telescope/telescope-ui-select.nvim",
      --   opts = {}
      -- }
    },
    opts = function()
      require("which-key").register({
        f = {
          name = "file",
          f = { "<cmd>Telescope find_files<cr>", "Find File" },
          r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        },
      }, {
        prefix = "<leader>",
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    tag = "v1.1.0",
    event = "LspAttach",
    opts = {},
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = function(_, _)
      require("which-key").register({
        m = {
          name = "Harpoon Marks",
          u = {
            function()
              require("harpoon.ui").toggle_quick_menu()
            end,
            "Quick Menu UI",
          },
          j = {
            function()
              require("harpoon.ui").nav_next()
            end,
            "Next Mark",
          },
          k = {
            function()
              require("harpoon.ui").nav_prev()
            end,
            "Previous Mark",
          },
          m = {
            function()
              require("harpoon.mark").add_file()
            end,
            "Mark",
          },
        },
      }, {
        prefix = "<leader>",
      })
    end,
  },
  "tpope/vim-fugitive",
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- setup here
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
})

require("guess-indent").setup({})
-- TODO: setup whichkey for this
require("Comment").setup({})
-- require("telescope").load_extension("ui-select")

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "lua",
    "rust",
    "typescript",
    "javascript",
    "java",
    "html",
    "c_sharp",
    "css",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitignore",
    "go",
    "gomod",
    "json",
    "make",
    "markdown",
    "nix",
    "sql",
  },
})

vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.cmd.colorscheme("nordic")

local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(_, bufnr)
  -- :help lsp-zero-keybindings
  -- TODO: setup whichkey for this
  lsp.default_keymaps({
    bugger = bufnr,
    preserve_mappings = false,
  })
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.ensure_installed({
  "lua_ls",
  "gopls",
  "eslint",
  "tailwindcss",
  "tsserver",
  "rust_analyzer",
  "rnix",
})

lsp.setup()
