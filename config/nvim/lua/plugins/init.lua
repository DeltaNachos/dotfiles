return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- 1. Setup shared LSP behaviors globally (Keymaps & Capabilities)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  
      vim.lsp.config("*", {
        capabilities = capabilities,
        -- The on_attach function applies mappings to any buff with an active client
        on_attach = function(_, bufnr)
          local nmap = function(keys, func, desc)
            if desc then desc = "LSP: " .. desc end
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end
  
          -- Core LSP Keymaps
          nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
          nmap("K", vim.lsp.buf.hover, "Hover Documentation")
          nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        end,
      })
  
      -- 2. Setup clangd with your custom command arguments
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
      })
  
      -- 3. Configure Mason-lspconfig to bridge into the native framework
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "clangd" },
        handlers = {
          -- The default handler runs for any server installed by Mason
          function(server_name)
            vim.lsp.enable(server_name)
          end,
        },
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      -- default settings
    },
    lazy = false,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
