local function github_colorscheme()
  return vim.o.background == "light" and "github_light_default" or "github_dark_default"
end

local function load_github_colorscheme()
  vim.cmd.colorscheme(github_colorscheme())
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = load_github_colorscheme,
    },
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    init = function()
      local group = vim.api.nvim_create_augroup("GithubThemeBackground", { clear = true })

      vim.api.nvim_create_autocmd("OptionSet", {
        group = group,
        pattern = "background",
        callback = function()
          vim.schedule(load_github_colorscheme)
        end,
      })
    end,
  },
}
