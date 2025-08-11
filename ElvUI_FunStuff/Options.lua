local E, L, _, P = unpack(ElvUI)
local FUN = E:GetModule('ElvUI_FunStuff')
local ACH = E.Libs.ACH
local RRP = LibStub('RepoocReforged-1.0'):LoadMainCategory()

local DEVELOPERS = {
	'|cff0070DEAzilroka|r',
	'Blazeflack',
	'|cff9482c9Darth Predator|r',
	'|cffFF3333Elv|r',
	'|cffFFC44DHydra|r',
	E:TextGradient('Simpy but my name needs to be longer.', 0.27,0.72,0.86, 0.51,0.36,0.80, 0.69,0.28,0.94, 0.94,0.28,0.63, 1.00,0.51,0.00, 0.27,0.96,0.43),
	'|cffFF8000Tukz|r',
}

local TESTERS = {
	'|cffeb9f24Tukui Community|r',
}

local function SortList(a, b)
	return E:StripString(a) < E:StripString(b)
end

sort(DEVELOPERS, SortList)
sort(TESTERS, SortList)

local DEVELOPER_STRING = table.concat(DEVELOPERS, '|n')
local TESTER_STRING = table.concat(TESTERS, '|n')

local function SetupNewProfile(info, value)
	if not info or not value or not FUN.availLayouts[info[#info-1]] then return end
	local tempName = FUN.availLayouts[info[#info-1]].profileName
	local currentProfile = E.data:GetCurrentProfile()
	local warning = false
	local newProfile = info[#info] == 'newProfile'

	if currentProfile == tempName then
		warning = true
	else
		for _ ,v in pairs(E.data:GetProfiles()) do
			if v == currentProfile then
				warning = true
				break
			end
		end
	end

	if warning then
		E.PopupDialogs.FUN_PROFILE_WARNING.text = format(L["|cffFF3333Warning:|r You already have a profile named, |cffFFD100%s|r.\n\nClick \"Overwrite\" to overwrite the profile or click \"Cancel\" to cancel the operation."], tempName)
		E:StaticPopup_Show('FUN_PROFILE_WARNING', nil, nil, {layout = info[#info-1]})
	else
		FUN.availLayouts[info[#info-1]].newProfileFunc(newProfile)
		ReloadUI()
	end
end

local function cubeActionGroup(info, which, line, ...)
	local db = E.db.fun.lines[which][line].cube

	if info[#info-1] == 'customGlow' then
		db = db.customGlow
	end

	if info.type == 'color' then
		local color = db[info[#info]]
		local r, g, b, a = ...
		if r then
			color.r, color.g, color.b, color.a = r, g, b, a
		else
			local d = P.fun.lines[which][line].cube[info[#info]]
			return color.r, color.g, color.b, color.a, d.r, d.g, d.b, d.a
		end
	else
		local value = ...
		if value ~= nil then
			db[info[#info]] = value
		else
			return db[info[#info]]
		end
	end

	FUN:UpdateOptions()
end

local function GetOptionsTable_CustomGlow(which, line)
	local db = E.db.fun.lines[which]
	local config = ACH:Group(L["Custom Glow"], nil, 10, nil, function(info) return db[line].customGlow[info[#info]] end, function(info, value) FUN:StopAllGlows() db[line].customGlow[info[#info]] = value FUN:UpdateOptions() end, function() return not db[line].useCustomGlow end)
	config.inline = true
	config.args.useStyle = ACH:Toggle(L["Custom Style"], nil, 0, nil, nil, nil, nil, nil, function() return not db.enable or not db[line].useCustomGlow end)
	config.args.style = ACH:Select(L["Style"], nil, 1, function() local tbl = {} for _, name in next, E.Libs.CustomGlow.glowList do if name == 'Pixel Glow' or name == 'Autocast Shine' then tbl[name] = name end end return tbl end, nil, nil, nil, nil, function(info) return not db.enable or not db[line].useCustomGlow or not db[line].customGlow.useStyle end)
	config.args.spacer1 = ACH:Spacer(2, 'full')
	config.args.speed = ACH:Range(L["SPEED"], nil, 3, { min = -1, max = 1, softMin = -0.5, softMax = 0.5, step = .01, bigStep = .05 }, nil, nil, nil, function(info) return not db.enable or not db[line].useCustomGlow end, function(info) local style = db[line].customGlow.useStyle and db[line].customGlow.style or db.customGlow.style return style == 'Proc Glow' end)
	config.args.duration = ACH:Range(L["SPEED"], nil, 3, { min = 0.1, max = 2, step = 0.1 }, nil, nil, nil, nil, function(info) local style = db[line].customGlow.useStyle and db[line].customGlow.style or db.customGlow.style return style ~= 'Proc Glow' end)
	config.args.size = ACH:Range(L["Size"], nil, 5, { min = 1, max = 5, step = 1 }, nil, nil, nil, function() return not db.enable or not db[line].useCustomGlow end, function(info) local style = db[line].customGlow.useStyle and db[line].customGlow.style or db.customGlow.style return style ~= 'Pixel Glow' end)
	config.args.lines = ACH:Range(function(info) local style = db[line].customGlow.useStyle and db[line].customGlow.style or db.customGlow.style return style == 'Pixel Glow' and L["Lines"] or L["Particles"] end, nil, 6, { min = 1, max = 20, step = 1 }, nil, nil, nil, function() return not db.enable or not db[line].useCustomGlow end, function(info) local style = db[line].customGlow.useStyle and db[line].customGlow.style or db.customGlow.style return style ~= 'Pixel Glow' and style ~= 'Autocast Shine' end)
	config.args.startAnimation = ACH:Toggle(L["Start Animation"], nil, 7, nil, nil, nil, nil, nil, nil, function(info) local db = E.db.fun.lines[which] local style = db[info[#info-2]][info[#info-1]].useStyle and db[info[#info-2]].customGlow.style or db.customGlow.style return style ~= 'Proc Glow' end)
	config.args.spacer2 = ACH:Spacer(10, 'full')
	config.args.useColor = ACH:Toggle(L["Custom Color"], nil, 11, nil, nil, nil, nil, nil, function() return not db.enable or not db[line].useCustomGlow end)
	config.args.color = ACH:Color(L["COLOR"], nil, 12, true, nil, function(info) local c, d = db[line].customGlow[info[#info]], P.fun.lines[which][line].customGlow[info[#info]] return c.r, c.g, c.b, c.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) local c = db[line].customGlow[info[#info]] c.r, c.g, c.b, c.a = r, g, b, a FUN:UpdateOptions() end, function(info) return not db.enable or not db[line].useCustomGlow or not db[line].customGlow.useColor end)

	return config
end

local lines = {
	left = {
		name = L["Left"],
		xOffset = {
			values = { min = 0, softMin = 0, softMax = 350, max = 750, step = 1 },
		},
	},
	right = {
		name = L["Right"],
		xOffset = {
			values = { min = -750, softMin = -350, softMax = 0, max = 0, step = 1 },
		},
	},
	horizontal = {
		name = L["Horizontal"],
		top = {
			yOffset = {
				values = { min = -750, softMin = -350, softMax = 0, max = 0, step = 1 },
			},
		},
		bottom = {
			yOffset = {
				values = { min = 0, softMin = 0, softMax = 350, max = 750, step = 1 },
			},
		},
	},
}

local function GetOptionsTable_Line(which, line, order)
	if not which or not line or not lines[line] then return end
	order = order and order + 13 or 14

	local db = E.db.fun.lines[which]
	local config = ACH:Group(lines[line].name, nil, order, nil, function(info) return db[line][info[#info]] end, function(info, value) db[line][info[#info]] = value FUN:UpdateOptions() end, function(info) if lines[info[#info]] then return false else return not db.enable end end)
	config.args.header1 = ACH:Header(L["Line Settings"], 0)
	if line == 'left' or line == 'right' then
		config.args.xOffset = ACH:Range(L["xOffset"], format(L["This will adjust the %s vertical line's distance from the edge of the screen, which determines the length of the horizontal line as well."], lines[line].name), 1, lines[line].xOffset.values)
		config.args.length = ACH:Range(L["Length"], nil, 2, { softMin = 5, min = 2, softMax = 250, max = 500, step = 1 })
	elseif line == 'horizontal' then
		config.args.yOffset = ACH:Range(L["yOffset"], L["This will adjust the Horizontal line's distance from the edge of the screen."], 1, lines[line][which].yOffset.values)
	end
	config.args.width = ACH:Range(L["Width"], L["Determines the thickness of the line."], 3, { softMin = 2, min = 2, softMax = 50, max = 100, step = 1 })
	config.args.spacer1 = ACH:Spacer(4, 'full')
	config.args.borderColor = ACH:Color(L["Border Color"], nil, 5, true, nil, function(info) local t = db[line][info[#info]] local d = P.fun.lines[which][line][info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) db[line][info[#info]] = {} local t = db[line][info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	config.args.backdropColor = ACH:Color(L["Backdrop Color"], nil, 6, true, nil, function(info) local t = db[line][info[#info]] local d = P.fun.lines[which][line][info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) db[line][info[#info]] = {} local t = db[line][info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	config.args.spacer2 = ACH:Spacer(7, 'full')
	config.args.useCustomGlow = ACH:Toggle(L["Use Custom Glow"], nil, 9, nil, nil, nil, nil, function(info, value) db[line][info[#info]] = value FUN:UpdateOptions() end)

	return config
end

local function GetOptionsTable_Lines(name, which, order)
	if not which or not E.db.fun.lines[which] then return end
	local db = E.db.fun.lines[which]
	--* Tukui Top Lines
	local config = ACH:Group(name, nil, order, 'tab', function(info) return db[info[#info]] end, function(info, value) FUN:StopAllGlows() db[info[#info]] = value FUN:UpdateOptions() end, function(info) if info[#info] == 'lines' or info[#info] == 'top' or info[#info] == 'bottom' then return false else return not db.enable end end)

	config.args.enable = ACH:Toggle(L["Enable"], nil, 0, nil, nil, nil, nil, nil, function() return false end)
	config.args.spacer = ACH:Spacer(1, 'full')

	config.args.customGlow = ACH:Group(L["Custom Glow"], nil, 5, nil, function(info) return db.customGlow[info[#info]] end, function(info, value) FUN:StopAllGlows() db.customGlow[info[#info]] = value FUN:UpdateOptions() end)
	config.args.customGlow.inline = true
	config.args.customGlow.args.style = ACH:Select(L["Style"], nil, 1, function() local tbl = {} for _, name in next, E.Libs.CustomGlow.glowList do if name == 'Pixel Glow' or name == 'Autocast Shine' then tbl[name] = name end end return tbl end)
	config.args.customGlow.args.color = ACH:Color(L["COLOR"], nil, 2, true, nil, function(info) local c, d = db.customGlow[info[#info]], P.fun.lines[which].customGlow[info[#info]] return c.r, c.g, c.b, c.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) FUN:StopAllGlows() local c = db.customGlow[info[#info]] c.r, c.g, c.b, c.a = r, g, b, a FUN:UpdateOptions() end, function() return not db.enable end)
	config.args.customGlow.args.spacer = ACH:Spacer(3, 'full')

	--! Top Left Line
	config.args.left = GetOptionsTable_Line(which, 'left', 1)

	--* Top Left Custom Glow
	config.args.left.args.customGlow = GetOptionsTable_CustomGlow(which, 'left')

	--* Top Left Cube
	config.args.left.args.spacer3 = ACH:Spacer(19, 'full')
	config.args.left.args.header2 = ACH:Header(L["Cube Settings"], 20)
	config.args.left.args.size = ACH:Range(L["Size"], nil, 21, { min = 2, max = 20, step = 1 }, nil, function(info) return cubeActionGroup(info, which, 'left') end, function(info, ...) cubeActionGroup(info, which, 'left', ...) end)
	config.args.left.args.spacer4 = ACH:Spacer(24, 'full')
	config.args.left.args.cubeBorderColor = ACH:Color(L["Border Color"], nil, 25, true, nil, function(info) local t = db.left.cube.borderColor local d = P.fun.lines[which].left.cube.borderColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) db.left.cube.borderColor = {} local t = db.left.cube.borderColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	config.args.left.args.cubeBackdropColor = ACH:Color(L["Backdrop Color"], nil, 26, true, nil, function(info) local t = db.left.cube.backdropColor local d = P.fun.lines[which].left.cube.backdropColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) db.left.cube.backdropColor = {} local t = db.left.cube.backdropColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)

	--! Top Horizontal Line
	config.args.horizontal = GetOptionsTable_Line(which, 'horizontal', 2)
	--* Top Horizontal Custom Glow
	config.args.horizontal.args.customGlow = GetOptionsTable_CustomGlow(which, 'horizontal')

	--! Top Right Line
	config.args.right = GetOptionsTable_Line(which, 'right', 3)
	--* Top Right Custom Glow
	config.args.right.args.customGlow = GetOptionsTable_CustomGlow(which, 'right')

	--* Top Right Cube
	config.args.right.args.spacer3 = ACH:Spacer(19, 'full')
	config.args.right.args.header2 = ACH:Header(L["Cube Settings"], 20)
	config.args.right.args.size = ACH:Range(L["Size"], nil, 21, { min = 2, max = 20, step = 1 }, nil, function(info) return cubeActionGroup(info, which, 'right') end, function(info, ...) cubeActionGroup(info, which, 'right', ...) end)
	config.args.right.args.spacer4 = ACH:Spacer(24, 'full')
	config.args.right.args.cubeBorderColor = ACH:Color(L["Border Color"], nil, 25, true, nil, function(info) local t = db.right.cube.borderColor local d = P.fun.lines[which].right.cube.borderColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) db.right.cube.borderColor = {} local t = db.right.cube.borderColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	config.args.right.args.cubeBackdropColor = ACH:Color(L["Backdrop Color"], nil, 26, true, nil, function(info) local t = db.right.cube.backdropColor local d = P.fun.lines[which].right.cube.backdropColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) db.right.cube.backdropColor = {} local t = db.right.cube.backdropColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)

	return config
end

local function configTable()
	--* Repooc Reforged Plugin section
	local rrp = E.Options.args.rrp

	--* Plugin Section
	local fun = ACH:Group(gsub(FUN.Title, "^.-|r%s", ""), nil, 6, 'tab', nil, nil)
	if not rrp then
		print("Error Loading Repooc Reforged Plugin Library, make sure to download the addon from Wago AddOns or Curseforge instead of github!")
		E.Options.args.fun = fun
	else
		rrp.args.fun = fun
	end

	local Options = ACH:Group(L["Options"], nil, 90, 'tab', function(info) return E.db.fun[info[#info-1]][info[#info]] end, function(info, value) E.db.fun[info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	fun.args.options = Options

	local Harlem = ACH:Group('|cffFFD100Harlem Shake|r', "this is a test desc to see how well this handles long as messages and just keep on going.  i don't know if i will use it but best to be safe than sorry.", 5, nil, nil, nil)
	Options.args.harlem = Harlem
	Harlem.inline = true
	Harlem.args.runHarlemShake = ACH:Execute(L["Run Harlem Shake"], nil, 1, function() E:HarlemShakeToggle() end, nil, nil, 200)

	local Kitty = ACH:Group('|cffDF4CBCHello Kitty|r', nil, 10, nil, nil, nil)
	Options.args.hellokitty = Kitty
	Kitty.inline = true
	Kitty.args.enable = ACH:Toggle(L["Show Dancing Kittys!"], nil, 0)
	Kitty.args.spacer = ACH:Spacer(1, 'full')
	Kitty.args.newProfile = ACH:Execute(L["Create New Profile"], nil, 5, function(info, value) SetupNewProfile(info, value) end, nil, nil, 200)
	Kitty.args.applyToProfile = ACH:Execute(L["Apply To Current Profile"], nil, 6, function(info, value) SetupNewProfile(info, value) end, nil, nil, 200)

	local Tukui = ACH:Group('|cffFF8000Tukui|r', nil, 10)
	Options.args.tukui = Tukui
	Tukui.inline = true
	Tukui.args.enable = ACH:Toggle(L["Show Tukui Bars"], nil, 0)
	Tukui.args.spacer = ACH:Spacer(1, 'full')
	Tukui.args.newProfile = ACH:Execute(L["Create New Profile"], nil, 5, function(info, value) SetupNewProfile(info, value) end, nil, nil, 200)

	local Lines = ACH:Group(L["|cffFF8000Tukui|r Lines"], nil, 0, 'tab', function(info) return E.db.fun[info[#info-1]][info[#info]] end, function(info, value) E.db.fun[info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	fun.args.lines = Lines

	--* Tukui Top Lines
	local top = GetOptionsTable_Lines('|cffFF8000Top|r Lines', 'top', 1)
	Lines.args.top = top

	--* Tukui Bottom Lines
	local bottom = GetOptionsTable_Lines('|cffFF8000Bottom|r Lines', 'bottom', 2)
	Lines.args.bottom = bottom

	local Help = ACH:Group(L["Help"], nil, 99, nil, nil, nil, false)
	fun.args.help = Help

	local Support = ACH:Group(L["Support"], nil, 1)
	Help.args.support = Support
	Support.inline = true
	Support.args.wago = ACH:Execute(L["Wago Page"], nil, 1, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://addons.wago.io/addons/fun-stuff-elvui-plugin') end, nil, nil, 140)
	Support.args.curse = ACH:Execute(L["Curseforge Page"], nil, 1, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://www.curseforge.com/wow/addons/fun-stuff-elvui-plugin') end, nil, nil, 140)
	Support.args.git = ACH:Execute(L["Ticket Tracker"], nil, 2, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://github.com/Repooc/ElvUI_FunStuff/issues') end, nil, nil, 140)
	-- Support.args.discord = ACH:Execute(L["Discord"], nil, 3, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://discord.gg/') end, nil, nil, 140, nil, nil, true)

	local Download = ACH:Group(L["Download"], nil, 2)
	Help.args.download = Download
	Download.inline = true
	Download.args.development = ACH:Execute(L["Development Version"], L["Link to the latest development version."], 1, function() E:StaticPopup_Show('ELVUI_EDITBOX', nil, nil, 'https://github.com/Repooc/ElvUI_FunStuff/archive/refs/heads/main.zip') end, nil, nil, 140)

	local Credits = ACH:Group(L["Credits"], nil, 5)
	Help.args.credits = Credits
	Credits.inline = true
	Credits.args.string = ACH:Description(E:TextGradient(L["FUN_CREDITS"], 0.27,0.72,0.86, 0.51,0.36,0.80, 0.69,0.28,0.94, 0.94,0.28,0.63, 1.00,0.51,0.00, 0.27,0.96,0.43), 1, 'medium')

	local Coding = ACH:Group(L["Coding"], nil, 6)
	Help.args.coding = Coding
	Coding.inline = true
	Coding.args.string = ACH:Description(DEVELOPER_STRING, 1, 'medium')

	local Testers = ACH:Group(L["Help Testing Development Versions"], nil, 7)
	Help.args.testers = Testers
	Testers.inline = true
	Testers.args.string = ACH:Description(TESTER_STRING, 1, 'medium')
end

tinsert(FUN.Configs, configTable)
