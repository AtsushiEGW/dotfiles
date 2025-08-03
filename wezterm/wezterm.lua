-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.font_size = 15.0
-- config.font = wezterm.font("UDEV Gothic 35NFLG")
-- config.font = wezterm.font("Firge35Nerd Console")
-- config.font = wezterm.font("HackGen35 Console NF")
-- config.font = wezterm.font("PlemolJP35 Console NF")
config.font = wezterm.font("FiraCode Nerd Font")

config.color_scheme = "OneHalfDark"

-- and finally, return the configuration to wezterm
return config
