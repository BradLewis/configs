return {
  { "neovim/nvim-lspconfig" },
  {
    "simrat39/rust-tools.nvim",
    opts = function(_, opts)
      local rt = require("rust-tools")

      local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- MacOS: This may be .dylib

      opts.server = {
        on_attach = function(_, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
              extraArgs = { "--all", "--", "-W", "clippy::all" },
            },
          },
        },
      }

      opts.dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      }
    end,
  },
}