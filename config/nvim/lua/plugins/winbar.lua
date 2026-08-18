-- Winbar configuration: dropbar.nvim for VSCode-like breadcrumbs
return {
  -- Reset built-in winbar (handed off to dropbar.nvim)
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      vim.opt.winbar = ""
    end,
  },

  -- dropbar.nvim: VSCode-like breadcrumbs with LSP/treesitter symbols
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        -- Provides fzf_lib C module required for dropbar's fuzzy find mode
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    opts = {
      menu = {
        keymaps = {
          ["h"] = function()
            local menu = require("dropbar.utils").menu.get_current()
            if not menu then return end
            if menu.prev_menu then
              -- Inside a submenu: go up one level
              menu:close()
            else
              -- At top level: move left to the previous breadcrumb segment
              local bar = require("dropbar.utils").bar.get({ win = menu.prev_win })
              if not bar then return end
              -- Find the index of the currently open segment
              local current_idx = nil
              for i, comp in ipairs(bar.components) do
                if comp.menu and comp.menu == menu then
                  current_idx = i
                  break
                end
              end
              if current_idx and current_idx > 1 then
                menu:close()
                bar:pick(current_idx - 1)
              end
            end
          end,
          ["l"] = function()
            local menu = require("dropbar.utils").menu.get_current()
            if not menu then return end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local entry = menu.entries[cursor[1]]
            if not entry then return end
            local component = entry:first_clickable(cursor[2])
            if component then
              local bar = require("dropbar.utils").bar.get({ win = menu.prev_win })
              menu:click_on(component)
              -- If no submenu opened (leaf entry): move right to the next breadcrumb segment
              local new_menu = require("dropbar.utils").menu.get_current()
              if new_menu == menu and bar then
                local current_idx = nil
                for i, comp in ipairs(bar.components) do
                  if comp.menu and comp.menu == menu then
                    current_idx = i
                    break
                  end
                end
                if current_idx and current_idx < #bar.components then
                  menu:close()
                  bar:pick(current_idx + 1)
                end
              end
            end
          end,
        },
      },
      bar = {
        sources = function(buf, _)
          local sources = require("dropbar.sources")
          local utils = require("dropbar.utils")

          if vim.bo[buf].ft == "markdown" then
            return {
              sources.path,
              sources.markdown,
            }
          end

          if vim.lsp.get_clients({ bufnr = buf })[1] then
            return {
              sources.path,
              utils.source.fallback({
                sources.lsp,
                sources.treesitter,
              }),
            }
          end

          return {
            sources.path,
            sources.treesitter,
          }
        end,
      },
    },
    keys = {
      {
        "gb",
        function()
          local bar = require("dropbar.utils").bar.get_current()
          if bar and bar.components then
            require("dropbar.api").pick(#bar.components)
          end
        end,
        mode = "n",
        desc = "Breadcrumb Pick (dropbar)",
      },
    },
  },
}
