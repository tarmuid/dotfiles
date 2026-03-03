return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            actions = {
              ["confirm"] = { action = "confirm", auto_close = false },
              ["toggle_hidden"] = { action = "toggle_hidden", auto_close = false },
            },
            win = {
              list = {
                keys = {
                  ["<CR>"] = "confirm",
                  ["<Tab>"] = "toggle_hidden",
                },
              },
            },
          },
          files = { hidden = true },
        },
      },
    },
  },
}
