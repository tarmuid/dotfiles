return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "dprint" },
        jsonc = { "dprint" },
      },
      formatters = {
        dprint = {
          command = "dprint",
          args = { "fmt", "--config-discovery=global", "--stdin", "$FILENAME" },
          stdin = true,
        },
      },
    },
  },
}
