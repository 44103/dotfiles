-- Winbar configuration: Display path in breadcrumb format
return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Set highlight groups
      vim.api.nvim_set_hl(0, "WinBarPath", { fg = "#808080", bg = "NONE" })
      vim.api.nvim_set_hl(0, "WinBarFile", { fg = "#DCDCAA", bg = "NONE", bold = true })

      -- Enable winbar
      vim.opt.winbar = "%{%v:lua.require'util.winbar'.get_winbar()%}"
    end,
  },
}
