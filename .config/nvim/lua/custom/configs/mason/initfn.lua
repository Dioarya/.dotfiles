local augroup = vim.api.nvim_create_augroup("mason.filetype", { clear = true })

---@type string
local snacks_notification_title = "Mason FileType"

---@type "compact" | "minimal" | "fancy"
local snacks_notification_style = "compact"

---@type integer
local snacks_notification_timeout = 5000

local initial_opts = {
  title = snacks_notification_title,
  style = snacks_notification_style,
  timeout = snacks_notification_timeout,
}

local function notify(msg, level, opts)
  local new_opts = vim.tbl_extend("force", initial_opts, opts)
  vim.notify(msg, level, new_opts)
end

return function()
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup,
    callback = function(event)
      local ok1, lsps = pcall(require, "custom.lsps")
      if not ok1 then
        return
      end

      local ok2, registry = pcall(require, "mason-registry")
      if not ok2 then
        return
      end

      local ok3, mason_lspconfig_mappings = pcall(require, "mason-lspconfig.mappings")
      if not ok3 then
        return
      end
      local mappings = mason_lspconfig_mappings.get_mason_map().lspconfig_to_package

      local ft = vim.bo[event.buf].filetype

      if not lsps.languages[ft] then
        return
      end

      registry.update(function()
        ---@class package_info
        ---@field lspconfig string lspconfig server name (e.g. lua_ls)
        ---@field mason string mason package name (e.g. lua-language-server)
        ---@field pkg Package mason package

        ---@type package_info[]
        local packages_to_install = {}

        ---@class unknown_package_info
        ---@field lspconfig string lspconfig server name from configurations
        ---@field mason string mason package name that failed to register

        ---@type unknown_package_info[]
        local unknown_packages = {}

        for _, name in ipairs(lsps.languages[ft].packages) do
          local package_name = mappings[name] or name

          ---@type boolean, Package
          local ok, pkg = pcall(registry.get_package, package_name)

          if not ok then
            table.insert(unknown_packages, { lspconfig = name, mason = package_name })
            goto continue
          end

          if not pkg:is_installed() and not pkg:is_installing() then
            table.insert(packages_to_install, { lspconfig = name, mason = package_name, pkg = pkg })
          end
          ::continue::
        end

        if #packages_to_install ~= 0 then
          local names = {}
          for _, info in ipairs(packages_to_install) do
            table.insert(names, info.lspconfig)
          end
          notify(
            "Installing: " .. table.concat(names, ", "),
            vim.log.levels.INFO,
            { id = "mason.filetype.install.notification" }
          )

          local installed = {}
          local failed = {}
          local completed = 0
          local total = #packages_to_install

          for _, info in ipairs(packages_to_install) do
            info.pkg:install():once("closed", function()
              if info.pkg:is_installed() then
                table.insert(installed, info.lspconfig)
              else
                table.insert(failed, info.lspconfig)
              end

              completed = completed + 1

              -- only fire summary once all installs have settled
              if completed == total then
                vim.schedule(function()
                  if #installed ~= 0 then
                    notify(
                      "Installed successfully: " .. table.concat(installed, ", "),
                      vim.log.levels.INFO,
                      { id = "mason.filetype.install.success.notification" }
                    )
                  end
                  if #failed ~= 0 then
                    notify(
                      "Failed to install: " .. table.concat(failed, ", "),
                      vim.log.levels.ERROR,
                      { id = "mason.filetype.install.failed.notification" }
                    )
                  end
                end)
              end
            end)
          end
        end

        if #unknown_packages ~= 0 then
          local unknown_names = {}
          for _, info in ipairs(unknown_packages) do
            table.insert(unknown_names, info.lspconfig)
          end
          notify(
            "Unknown: " .. table.concat(unknown_names, ", "),
            vim.log.levels.WARN,
            { id = "mason.filetype.unknown.notification" }
          )
        end
      end)
    end,
  })
end
