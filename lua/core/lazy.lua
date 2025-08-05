require("lazy").setup("plugins", {
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "kanagawa" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
}) 