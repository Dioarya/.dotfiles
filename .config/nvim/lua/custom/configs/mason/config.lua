local augroup = vim.api.nvim_create_augroup("mason.filetype", { clear = true })

---@type string
local snacks_notification_title = "Mason FileType"

---@type "compact" | "minimal" | "fancy"
local snacks_notification_style = "compact"

---@type integer
local snacks_notification_timeout = 5000

return function(_, opts)
  require("mason").setup(opts)

  -- Automatically install preconfigured mason packages based on filetype. This prevents the need for extraneous packages
  -- to be installed on new machines that don't need them

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = augroup,
    callback = function(event)
      local ok1, lsps = pcall(require, "custom.lsps")
      if not ok1 then
        return
      end
      local servers = lsps.languages

      local ok2, registry = pcall(require, "mason-registry")
      if not ok2 then
        return
      end

      local ok3, mason_lspconfig_mappings = pcall(require, "mason-lspconfig.mappings")
      if not ok3 then
        return
      end
      local mappings = mason_lspconfig_mappings.get_mason_map().lspconfig_to_package

      local ft = vim.bo[event.buf].ft
      local lang = vim.treesitter.language.get_lang(ft)

      if lang and servers[lang] then
        registry.update(function()
          ---@class package_info
          ---@field lspconfig string lspconfig server name (e.g. lua_ls)
          ---@field mason string mason server name (e.g. lua-language-server)
          ---@field pkg any mason package

          ---@type package_info[]
          local packages_to_install = {}

          ---@class unknown_package_info
          ---@field lspconfig string lspconfig server name from configurations
          ---@field mason string mason package name that failed to register (very likely to be equal to `lspconfig`)

          ---@type unknown_package_info[]
          local unknown_packages = {}

          for _, name in ipairs(servers[lang]) do
            local package_name = mappings[name] or name
            ---@alias mason_package_callback fun(): boolean

            ---@class mason_package_base
            ---@field is_installed mason_package_callback the package has been installed
            ---@field is_installing mason_package_callback the package is installing

            ---@type boolean, mason_package_base
            local ok, pkg = pcall(registry.get_package, package_name)

            if not ok then
              ---@type unknown_package_info
              local unknown_package = {
                lspconfig = name,
                mason = package_name,
              }
              table.insert(unknown_packages, unknown_package)
              goto continue
            end

            if not pkg:is_installed() and not pkg:is_installing() then
              ---@type package_info
              local package = {
                lspconfig = name,
                mason = package_name,
                pkg = pkg,
              }
              table.insert(packages_to_install, package)
            end
            ::continue::
          end

          if #packages_to_install ~= 0 then
            local names = {}
            for _, info in ipairs(packages_to_install) do
              table.insert(names, info.lspconfig)
            end
            vim.notify("Installing " .. table.concat(names, ", "), "info", {
              title = snacks_notification_title,
              style = snacks_notification_style,
              timeout = snacks_notification_timeout,
              id = "mason.filetype.install.notification",
            })
            for _, info in ipairs(packages_to_install) do
              info.pkg:install()
            end
          end

          if #unknown_packages ~= 0 then
            local unknown_names = {}
            for _, info in ipairs(unknown_packages) do
              table.insert(unknown_names, info.lspconfig)
            end
            vim.notify("Unknown " .. table.concat(unknown_names, ", "), "warn", {
              title = snacks_notification_title,
              style = snacks_notification_style,
              timeout = snacks_notification_timeout,
              id = "mason.filetype.unknown.notification",
            })
          end
        end)
      end
    end,
  })
end
