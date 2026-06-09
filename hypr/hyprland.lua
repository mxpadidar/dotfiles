local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "hyprlauncher"

hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "0x0", scale = 1.2 })

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpaper")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 2,
		col = { active_border = "rgba(F8EDFFB3)", inactive_border = "rgba(222222ff)" },
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 2,
		rounding_power = 10,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = { enabled = true, range = 4, render_power = 3, color = "rgba(171717ee)" },
		blur = { enabled = false },
	},

	animations = { enabled = true },
})

-- Default curves and animations
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

hl.config({
	input = {
		kb_layout = "us,ir",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:win_space_toggle",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- Example per-device config
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local superShift = "SUPER + SHIFT"

-- Basic commands
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- close window
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal)) -- open terminal
hl.bind(mainMod .. " + X", hl.dsp.exit()) -- exit Hyprland
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager)) -- open file manager
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" })) -- toggle floating
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(menu)) -- open app launcher
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- toggle pseudotiling
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/hypr/reload.sh")) -- reload config

-- Custom bindings
hl.bind(superShift .. " + L", hl.dsp.exec_cmd("hyprlock")) -- lock screen
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" })) -- next workspace
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(terminal .. " -e impala")) -- wifi TUI
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(terminal .. " -e bluetui")) -- bluetooth TUI
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(terminal .. " -e pulsemixer")) -- audio TUI

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" })) -- focus left
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" })) -- focus down
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" })) -- focus up
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" })) -- focus right
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "left" })) -- focus left
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "down" })) -- focus down
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "up" })) -- focus up
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "right" })) -- focus right

-- Scratchpad workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic")) -- toggle scratchpad
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" })) -- send to scratchpad

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" })) -- next workspace
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" })) -- previous workspace

-- Move/resize windows with mainMod + mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- move window
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- resize window

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen()) -- toggle fullscreen

-- Screenshots
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window")) -- screenshot window
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output")) -- screenshot output
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region")) -- screenshot region

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Brightness controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media controls (requires playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- ignore maximize events to prevent Hyprland from resizing windows that try to maximize themselves (like Firefox)
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Hyprland-run window rule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

-- Remove gaps when a workspace has only one tiled window
hl.workspace_rule({ workspace = "w[tv1]", gaps_in = 0, gaps_out = 0 })

-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = 1 })

-- hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1" })
-- hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
-- hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
-- hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
-- hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1" })
-- hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1" })
-- hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
-- hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })
