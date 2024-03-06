local options = {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "rust" },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    use_languagetree = true,
  },

  indent = { enable = true },
}

return options
