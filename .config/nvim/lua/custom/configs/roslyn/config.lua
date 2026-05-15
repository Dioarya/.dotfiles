---@type string
local snacks_notification_title = "Roslyn"

---@type "compact" | "minimal" | "fancy"
local snacks_notification_style = "compact"

---@type integer
local snacks_notification_timeout = 5000

return function(_, opts)
  local registry = require "mason-registry"

  -- refresh ensures the Crashdummyy registry (declared in mason opts) is fetched
  -- before we attempt to look up the roslyn package, since it may not be in the
  -- default mason-org registry
  registry.refresh(function()
    local ok, pkg = pcall(registry.get_package, "roslyn")

    if not ok then
      vim.notify("Package not found in any registry", vim.log.levels.ERROR, {
        title = snacks_notification_title,
        style = snacks_notification_style,
        timeout = snacks_notification_timeout,
        id = "roslyn.install.not_found",
      })
      return
    end

    if pkg:is_installed() then
      require("roslyn").setup(opts)
      return
    end

    vim.notify("Not installed, installing via mason...", vim.log.levels.INFO, {
      title = snacks_notification_title,
      style = snacks_notification_style,
      timeout = snacks_notification_timeout,
      id = "roslyn.install.pending",
    })

    pkg:install():once("closed", function()
      if pkg:is_installed() then
        vim.schedule(function()
          require("roslyn").setup(opts)
        end) -- vim.schedule defers setup back onto the main loop after the async install
        vim.notify("Installed successfully", vim.log.levels.INFO, {
          title = snacks_notification_title,
          style = snacks_notification_style,
          timeout = snacks_notification_timeout,
          id = "roslyn.install.success",
        })
      else
        vim.notify("Installation failed", vim.log.levels.ERROR, {
          title = snacks_notification_title,
          style = snacks_notification_style,
          timeout = snacks_notification_timeout,
          id = "roslyn.install.failed",
        })
      end
    end)
  end)
end
