local augroup = vim.api.nvim_create_augroup("mason.filetype", { clear = true })

return function(_, opts)
  require("mason").setup(opts)

  local lsps = require("custom.lsps").filetypes
  local registry = require "mason-registry"
  local mappings = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package

  -- Automatically install preconfigured mason packages based on filetype. This prevents the need for extraneous packages
  -- to be installed on new machines that don't need them

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup,
    callback = function(event)
      local ft = vim.bo[event.buf].filetype

      if ft and lsps[ft] then
        registry.refresh(function()
          ---@class package_info
          ---@field lspconfig string lspconfig server name (e.g. lua_ls)
          ---@field mason string mason server name (e.g. lua-language-server)
          ---@field package
          local packages_to_install = {}

          for _, name in ipairs(lsps[ft]) do
            local package_name = mappings[name] or name
            local ok, pkg = pcall(registry.get_package, package_name)
            if ok and not pkg:is_installed() and not pkg:is_installing() then
              table.insert(packages_to_install, { lspconfig = name, mason = package_name, package = pkg })
            end
          end

          if #packages_to_install == 0 then
            return
          end

          local names = {}
          for _, info in ipairs(packages_to_install) do
            table.insert(names, info.lspconfig)
          end
          vim.notify("Mason (FileType): Installing " .. table.concat(names, ", "))

          for _, info in ipairs(packages_to_install) do
            info.package:install()
          end
        end)
      end
    end,
  })
end
