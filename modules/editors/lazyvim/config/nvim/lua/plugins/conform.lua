return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "dprint" },
        jsonc = { "dprint" },
        swift = { "swiftformat" },
        objc = { "clang-format" },
        objcpp = { "clang-format" },
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
