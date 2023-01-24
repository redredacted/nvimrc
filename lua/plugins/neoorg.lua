return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  opts = {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp"
        }
      }, -- Adds completion integration with nvim-cmp
      ["core.integrations.nvim-cmp"] = {},
      ["core.norg.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
          },
        },
      },
    },
  },
  dependencies = { { "nvim-lua/plenary.nvim" } },
}
