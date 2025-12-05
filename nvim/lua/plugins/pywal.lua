return {
  {
    "AlphaTechnolog/pywal.nvim",
    name = "pywal",
    lazy = false,
    priority = 1000,
    config = function()
      local pywal = require("pywal")

      pywal.setup()
      vim.cmd("colorscheme pywal")

      -- FORCE TRANSPARENCY (Ported from your Ayu config)
      -- This ensures the background is truly clear, not just dark grey
      local transparent_groups = {
        "Normal",
        "NormalFloat",
        "NormalNC",
        "SignColumn",
        "Folded",
        "FoldColumn",
        "CursorLine",
        "CursorColumn",
        "WhichKeyFloat",
        "VertSplit",
        "StatusLine",
        "StatusLineNC",
        "WinBar",
        "WinBarNC",
      }

      for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
      end
    end,
  },

  -- Configure LazyVim to use this color scheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "pywal",
    },
  },

  -- Make Lualine (Status Bar) match the Pywal theme
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "pywal"
    end,
  },
}
