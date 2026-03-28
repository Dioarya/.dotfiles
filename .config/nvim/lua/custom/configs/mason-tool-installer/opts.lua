return {
  ensure_installed = {}, -- Ensures all lsps are installed
  run_on_start = true, -- Automatically start
  auto_update = true, -- Auto updates any lsps
  start_delay = 10000, -- 10 second start delay
  debounce_hours = 5, -- 5 hours before retrying installs/updates
}
