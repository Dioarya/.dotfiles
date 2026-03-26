return {
  registries = {
    "github:Crashdummyy/mason-registry", -- Contains the Roslyn register
    "github:mason-org/mason-registry",
  },

  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,
}
