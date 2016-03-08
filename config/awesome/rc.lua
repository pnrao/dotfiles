-- Standard awesome library
gears = require("gears")
awful = require("awful")
rules = require("awful.rules")
autofocus = require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
xdg_menu = require("archmenu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
					 title = "Oops, there were errors during startup!",
					 text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
						 title = "Oops, an error happened!",
						 text = err })
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
theme_lua="/home/prash/.config/awesome/themes/prash/theme.lua"
beautiful.init(theme_lua)

-- This is used later as the default terminal and editor to run.
terminal = "konsole"
-- terminal = "urxvt -bg " .. awful.util.pread("/home/prash/bin/bgcolor")
editor = "scite"
editor_cmd = editor
file_manager = "spacefm"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
	awful.layout.suit.floating,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier
}
-- }}}


-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor .. " " .. awesome.conffile .. " " .. theme_lua  .. " /home/prash/.xbindkeysrc " .. " /home/prash/bin/startup.sh "},
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
	{ "terminal", function () awful.util.spawn("urxvt -bg " .. awful.util.pread("/home/prash/bin/bgcolor")) end, "/usr/share/icons/MeliaeSVG/apps/48/utilities-terminal.svg" },
	{ "kvkbd", function () awful.util.spawn("kvkbd") end, "/usr/share/apps/kvkbd/pics/tray.png" },
									{ "Applications", xdgmenu },
									-- { "edit config", editor_cmd .. " " .. awesome.conffile, beautiful.awesome_icon },
									{ "Exit", "/home/prash/bin/shutdown_dialog.sh", "/usr/share/icons/MeliaeSVG/stock/48/stock_exit.svg"}
								 },
						  theme = { width=160}
						})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
									 menu = mymainmenu })

-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %a %b %d, %H:%M ")

--~ volumebar = awful.widget.progressbar()
--~ volumebar:set_width(20)
--~ volumebar:set_height(20)
--~ volumebar:set_background_color('#A04B4F')
--~ volumebar:set_color('#AECF96')
--~ volumebar:set_value(0.5)
--~ volumebar:buttons(awful.util.table.join(
--~		awful.button({ }, 1, function()
--~			awful.util.spawn("pavucontrol", false)
--~		end),
--~		awful.button({ }, 3, function()
--~			volume('m')
--~		end),
--~		awful.button({ }, 4, function()
--~			volume('u')
--~		end),
--~		awful.button({ }, 5, function()
--~			volume('d')
--~		end)
--~ ))

--~ pa_channel = " 0 "
--~ pa_volume = 32768
--~ pa_step = 2048
--~ function volume(mode)
--~		if mode == 'u' then
--~			pa_volume = pa_volume + pa_step
--~			if pa_volume > 65535 then
--~				pa_volume = 65535
--~			end
--~			awful.util.spawn("pactl set-sink-volume 0 -- +1%", false)
--~			-- print(pa_volume)
--~			volumebar:set_value(pa_volume/65535)
--~		elseif mode == 'd' then
--~			pa_volume = pa_volume - pa_step
--~			if pa_volume < 0 then
--~				pa_volume = 0
--~			end
--~			awful.util.spawn("pactl set-sink-volume 0 -- -1%", false)
--~			-- print(pa_volume)
--~			volumebar:set_value(pa_volume/65535)
--~		elseif mode == 'm' then
--~			-- mute
--~		end
--~ end

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
					awful.button({ }, 1, awful.tag.viewonly),
					awful.button({ modkey }, 1, awful.client.movetotag),
					awful.button({ }, 3, awful.tag.viewtoggle),
					awful.button({ modkey }, 3, awful.client.toggletag),
					awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
					awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
					)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
					 awful.button({ }, 1, function (c)
											  --if c == client.focus then
											  --    c.minimized = true
											  --else
												  -- Without this, the following
												  -- :isvisible() makes no sense
												  c.minimized = false
												  if not c:isvisible() then
													  awful.tag.viewonly(c:tags()[1])
												  end
												  -- This will also un-minimize
												  -- the client, if needed
												  client.focus = c
												  c:raise()
											  end),
					 awful.button({ }, 2, function (c)
											  c:kill()
										  end),
					 awful.button({ }, 3, function ()
											  if instance then
												  instance:hide()
												  instance = nil
											  else
												  instance = awful.menu.clients({ width=250 })
											  end
										  end),
					 awful.button({ }, 4, function ()
											  awful.client.focus.byidx(1)
											  if client.focus then client.focus:raise() end
										  end),
					 awful.button({ }, 5, function ()
											  awful.client.focus.byidx(-1)
											  if client.focus then client.focus:raise() end
										  end))

for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
						   awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
						   awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
						   awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
						   awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

	-- Create the wibox
	mywibox[s] = awful.wibox({ position = "left", screen = s })

	-- Widgets that are aligned to the left
	local first_layout = wibox.layout.fixed.horizontal()
	first_layout:add(mylayoutbox[s])
	first_layout:add(mypromptbox[s])
	--if s == 1 then second_layout:add(wibox.widget.systray()) end -- Uli
	if s == 1 then
		local systray = wibox.widget.systray()
		-- systray:set_horizontal(false)
		-- systray:set_base_size(100)
		first_layout:add(systray)
	end
--	first_layout:add(volumebar)
	first_layout:add(mytaglist[s])

	-- Widgets that are aligned to the right
	local second_layout = wibox.layout.fixed.horizontal()

	second_layout:add(mytextclock)
	second_layout:add(mylauncher)

	-- Now bring it all together (with the tasklist in the middle)
	local layout = wibox.layout.align.horizontal() -- Prash: the probelem line
	layout:set_first(first_layout)
	layout:set_second(mytasklist[s])
	layout:set_third(second_layout)

	--mywibox[s]:set_widget(layout)
	local rotate = wibox.layout.rotate()
	rotate:set_direction("east") -- might also "west", I'm unsure
	rotate:set_widget(layout)
	mywibox[s]:set_widget(rotate)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
	awful.button({ }, 3, function () mymainmenu:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
	awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
	--awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

	awful.key({ "Mod1",           }, "Tab",
		function ()
			awful.client.focus.byidx( 1)
			if client.focus then client.focus:raise() end
		end),
	awful.key({ "Mod1", "Shift"   }, "Tab",
		function ()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
		end),
	awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

	-- Layout manipulation
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
	awful.key({ modkey,           }, ",", function () awful.screen.focus_relative( 1) end),
	awful.key({ modkey,           }, ".", function () awful.screen.focus_relative(-1) end),
	awful.key({ modkey,           }, "g", awful.client.urgent.jumpto),
	-- Resize window (move bottom-right corner)
	awful.key({ modkey, "Control" }, "Down",  function () awful.client.moveresize(  0,   0,   0,  20) end),
	awful.key({ modkey, "Control" }, "Up",    function () awful.client.moveresize(  0,   0,   0, -20) end),
	awful.key({ modkey, "Control" }, "Left",  function () awful.client.moveresize(  0,   0, -20,   0) end),
	awful.key({ modkey, "Control" }, "Right", function () awful.client.moveresize(  0,   0,  20,   0) end),
	-- Move window
	awful.key({ modkey, "Shift"   }, "Down",  function () awful.client.moveresize(  0,  10,   0,   0) end),
	awful.key({ modkey, "Shift"   }, "Up",    function () awful.client.moveresize(  0, -10,   0,   0) end),
	awful.key({ modkey, "Shift"   }, "Left",  function () awful.client.moveresize(-10,   0,   0,   0) end),
	awful.key({ modkey, "Shift"   }, "Right", function () awful.client.moveresize( 10,   0,   0,   0) end),

	-- Standard program
	awful.key({ modkey,           }, "t", function () awful.util.spawn(terminal) end),

	awful.key({ modkey, "Control" }, "r", awesome.restart),
	awful.key({ modkey, "Control" }, "q", awesome.quit),

	awful.key({ modkey,           }, "]",     function () awful.tag.incmwfact( 0.05)    end),
	awful.key({ modkey,           }, "[",     function () awful.tag.incmwfact(-0.05)    end),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
	awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

	awful.key({ modkey, "Control" }, "n", awful.client.restore),


	awful.key({ modkey }, "x",
			  function ()
				  awful.prompt.run({ prompt = "Run Lua code: " },
				  mypromptbox[mouse.screen].widget,
				  awful.util.eval, nil,
				  awful.util.getdir("cache") .. "/history_eval")
			  end)
)

clientkeys = awful.util.table.join(
	awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
	awful.key({ "Mod1",           }, "F4",     function (c) c:kill()                         end),
	awful.key({ modkey,           }, "h",      awful.client.floating.toggle             ), --hover
	awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
	awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
	awful.key({ modkey,           }, "a",      function (c) c.ontop = not c.ontop            end),
	awful.key({ modkey,           }, "c",      function (c) c.sticky = not c.sticky            end),
	--awful.key({ modkey,           }, "n",
	--    function (c)
	--        -- The client currently has the input focus, so it cannot be
	--        -- minimized, since minimized clients can't have the focus.
	--        c.minimized = true
	--    end),
	awful.key({ modkey,           }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c.maximized_vertical   = c.maximized_horizontal
		end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
	globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, "#" .. i + 9,
				  function ()
						local screen = mouse.screen
						if tags[screen][i] then
							awful.tag.viewonly(tags[screen][i])
						end
				  end),
		awful.key({ modkey, "Control" }, "#" .. i + 9,
				  function ()
					  local screen = mouse.screen
					  if tags[screen][i] then
						  awful.tag.viewtoggle(tags[screen][i])
					  end
				  end),
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
				  function ()
					  if client.focus and tags[client.focus.screen][i] then
						  awful.client.movetotag(tags[client.focus.screen][i])
					  end
				  end),
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
				  function ()
					  if client.focus and tags[client.focus.screen][i] then
						  awful.client.toggletag(tags[client.focus.screen][i])
					  end
				  end))
end

clientbuttons = awful.util.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
	  properties = { border_width = beautiful.border_width,
					 border_color = beautiful.border_normal,
					 focus = awful.client.focus.filter,
					 keys = clientkeys,
					 buttons = clientbuttons } },
	{ rule = { class = "Kvkbd" },
	  properties = { floating = true } },
	{ rule = { class = "MPlayer" },
	  properties = { floating = true } },
	{ rule = { class = "pinentry" },
	  properties = { floating = true } },
	{ rule = { class = "gimp" },
	  properties = { floating = true } },
	{ rule = { class = "wicd-client.py" },
	  properties = { floating = true, height = 450, width = 400} },
	{ rule = { class = "eric5.py", name = "Mercurial" },
	  properties = { floating = true } },
	{ rule = { class = "thunar"},
	  properties = { height = 382, width = 672} },
	{ rule = { class = "pavucontrol"},
	  properties = { floating = true, height = 382, width = 672} },
	{ rule_any = { role = {"About", "about"} },
	  properties = { floating = true} },
	{ rule_any = { role = {"kile", "okular"} },
	  properties = { maximized_horizontal = false, maximized_vertical = false} },

	-- Set Pidgin to always map on tags number 9 of screen 1.
	{ rule = { class = "Pidgin", role = "buddy_list" },
	  properties = { tag = tags[1][9], width = 250, maximized_vertical = true } },
	{ rule = { class = "Skype"},
	  properties = { tag = tags[1][9]} },
	{ rule = { class = "Pidgin", role = "conversation" },
	  properties = { tag = tags[1][9]} },
	{ rule = { class = "Thunderbird" },
	  properties = { tag = tags[1][8] } },
	{ rule = { class = "Earlybird" },
	  properties = { tag = tags[1][8] } },
	{ rule = { class = "xdot.py" },
	  properties = { tag = tags[1][5] } },
	{ rule = { class = "xdot" },
	  properties = { tag = tags[1][5] } },
	{ rule = { class = "ktorrent" },
	  properties = { tag = tags[1][7] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
	-- Enable sloppy focus
	c:connect_signal("mouse::enter", function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			and awful.client.focus.filter(c) then
			client.focus = c
		end
	end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end

	local titlebars_enabled = false
	if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
		-- Widgets that are aligned to the left
		local left_layout = wibox.layout.fixed.horizontal()
		left_layout:add(awful.titlebar.widget.iconwidget(c))

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		right_layout:add(awful.titlebar.widget.floatingbutton(c))
		right_layout:add(awful.titlebar.widget.maximizedbutton(c))
		right_layout:add(awful.titlebar.widget.stickybutton(c))
		right_layout:add(awful.titlebar.widget.ontopbutton(c))
		right_layout:add(awful.titlebar.widget.closebutton(c))

		-- The title goes in the middle
		local title = awful.titlebar.widget.titlewidget(c)
		title:buttons(awful.util.table.join(
				awful.button({ }, 1, function()
					client.focus = c
					c:raise()
					awful.mouse.client.move(c)
				end),
				awful.button({ }, 3, function()
					client.focus = c
					c:raise()
					awful.mouse.client.resize(c)
				end)
				))

		-- Now bring it all together
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		layout:set_right(right_layout)
		layout:set_middle(title)

		awful.titlebar(c):set_widget(layout)
	end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

function run_once(prg,arg_string,pname,screen)
	if not prg then
		do return nil end
	end

	if not pname then
	   pname = prg
	end

	if not arg_string then
		awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")",screen)
	else
		awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname ..  " " .. arg_string .. "' || (" .. prg .. " " .. arg_string .. ")",screen)
	end
end

run_once("/home/prash/bin/startup.sh")
