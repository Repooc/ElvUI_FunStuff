local E, L, _, P = unpack(ElvUI)
local FUN = E:GetModule('ElvUI_FunStuff')
local FUNCL = E:GetModule('FunStuff-Changelog')
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

local function configTable()
	--* Repooc Reforged Plugin section
	local rrp = E.Options.args.rrp

	--* Plugin Section
	local fun = ACH:Group('|cff00FF98Fun|r|cffA330C9Stuff|r', nil, 6, 'tab', nil, nil)
	if not rrp then
		print("Error Loading Repooc Reforged Plugin Library, make sure to download the addon from Wago AddOns or Curseforge instead of github!")
		E.Options.args.fun = fun
	else
		rrp.args.fun = fun
	end

	local Options = ACH:Group(L["Options"], nil, 0, 'tab', function(info) return E.db.fun[info[#info-1]][info[#info]] end, function(info, value) E.db.fun[info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
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

	--* Tukui Top Lines
	local top = ACH:Group('|cffFF8000Top|r Lines', nil, 98, 'tab', function(info) return E.db.fun.lines[info[#info-1]][info[#info]] end, function(info, value) E.db.fun.lines[info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	Options.args.top = top
	top.args.enable = ACH:Toggle(L["Enable"], nil, 0)
	top.args.spacer = ACH:Spacer(1, 'full')

	top.args.horizontal = ACH:Group(L["Horizontal"], nil, 14, nil, function(info) return E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	top.args.horizontal.inline = true
	top.args.horizontal.args.yOffset = ACH:Range(L["yOffset"], L["This will adjust the Horizontal line's distance from the edge of the screen."], 1, { min = -750, softMin = -350, softMax = 0, max = 0, step = 1 })
	top.args.horizontal.args.width = ACH:Range(L["Width"], L["Determines the thickness of the line."], 3, { softMin = 2, min = 2, softMax = 50, max = 100, step = 1 })
	top.args.horizontal.args.spacer1 = ACH:Spacer(4, 'full')
	top.args.horizontal.args.borderColor = ACH:Color(L["Border Color"], nil, 14, true, nil, function(info) local t = E.db.fun.lines.top.horizontal[info[#info]] local d = P.fun.lines.top.horizontal[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.horizontal[info[#info]] = {} local t = E.db.fun.lines.top.horizontal[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	top.args.horizontal.args.backdropColor = ACH:Color(L["Backdrop Color"], nil, 14, true, nil, function(info) local t = E.db.fun.lines.top.horizontal[info[#info]] local d = P.fun.lines.top.horizontal[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.horizontal[info[#info]] = {} local t = E.db.fun.lines.top.horizontal[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)

	top.args.left = ACH:Group(L["Left"], nil, 15, nil, function(info) return E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	top.args.left.inline = true
	top.args.left.args.xOffset = ACH:Range(L["xOffset"], format(L["This will adjust the %s vertical line's distance from the edge of the screen, which determines the length of the horizontal line as well."], L["Left"]), 1, { softMin = 0, min = 0, softMax = 350, max = 750, step = 1 })
	top.args.left.args.length = ACH:Range(L["Length"], nil, 2, { softMin = 5, min = 2, softMax = 250, max = 500, step = 1 })
	top.args.left.args.width = ACH:Range(L["Width"], L["Determines the thickness of the line."], 3, { softMin = 2, min = 2, softMax = 50, max = 100, step = 1 })
	top.args.left.args.spacer1 = ACH:Spacer(4, 'full')
	top.args.left.args.header1 = ACH:Header(L["Line Color"], 15)
	top.args.left.args.borderColor = ACH:Color(L["Border Color"], nil, 16, true, nil, function(info) local t = E.db.fun.lines.top.left[info[#info]] local d = P.fun.lines.top.left[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.left[info[#info]] = {} local t = E.db.fun.lines.top.left[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	top.args.left.args.backdropColor = ACH:Color(L["Backdrop Color"], nil, 17, true, nil, function(info) local t = E.db.fun.lines.top.left[info[#info]] local d = P.fun.lines.top.left[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.left[info[#info]] = {} local t = E.db.fun.lines.top.left[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	top.args.left.args.header2 = ACH:Header(L["Cube Color"], 20)
	top.args.left.args.cubeBorderColor = ACH:Color(L["Border Color"], nil, 21, true, nil, function(info) local t = E.db.fun.lines.top.left.cube.borderColor local d = P.fun.lines.top.left.cube.borderColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.left.cube.borderColor = {} local t = E.db.fun.lines.top.left.cube.borderColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	top.args.left.args.cubeBackdropColor = ACH:Color(L["Backdrop Color"], nil, 22, true, nil, function(info) local t = E.db.fun.lines.top.left.cube.backdropColor local d = P.fun.lines.top.left.cube.backdropColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.left.cube.backdropColor = {} local t = E.db.fun.lines.top.left.cube.backdropColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)

	top.args.right = ACH:Group(L["Right"], nil, 16, nil, function(info) return E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	top.args.right.inline = true
	top.args.right.args.xOffset = ACH:Range(L["xOffset"], format(L["This will adjust the %s vertical line's distance from the edge of the screen, which determines the length of the horizontal line as well."], L["Right"]), 1, { min = -750, softMin = -350, softMax = 0, max = 0, step = 1 })
	top.args.right.args.length = ACH:Range(L["Length"], nil, 2, { softMin = 5, min = 2, softMax = 250, max = 500, step = 1 })
	top.args.right.args.width = ACH:Range(L["Width"], L["Determines the thickness of the line."], 3, { softMin = 2, min = 2, softMax = 50, max = 100, step = 1 })
	top.args.right.args.spacer1 = ACH:Spacer(4, 'full')
	top.args.right.args.header1 = ACH:Header(L["Line Color"], 15)
	top.args.right.args.borderColor = ACH:Color(L["Border Color"], nil, 16, true, nil, function(info) local t = E.db.fun.lines.top.right[info[#info]] local d = P.fun.lines.top.right[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.right[info[#info]] = {} local t = E.db.fun.lines.top.right[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	top.args.right.args.backdropColor = ACH:Color(L["Backdrop Color"], nil, 17, true, nil, function(info) local t = E.db.fun.lines.top.right[info[#info]] local d = P.fun.lines.top.right[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.right[info[#info]] = {} local t = E.db.fun.lines.top.right[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	top.args.right.args.header2 = ACH:Header(L["Cube Color"], 20)
	top.args.right.args.cubeBorderColor = ACH:Color(L["Border Color"], nil, 21, true, nil, function(info) local t = E.db.fun.lines.top.right.cube.borderColor local d = P.fun.lines.top.right.cube.borderColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.right.cube.borderColor = {} local t = E.db.fun.lines.top.right.cube.borderColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	top.args.right.args.cubeBackdropColor = ACH:Color(L["Backdrop Color"], nil, 22, true, nil, function(info) local t = E.db.fun.lines.top.right.cube.backdropColor local d = P.fun.lines.top.right.cube.backdropColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.top.right.cube.backdropColor = {} local t = E.db.fun.lines.top.right.cube.backdropColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)

	--* Tukui Bottom Lines
	local bottom = ACH:Group('|cffFF8000Bottom|r Lines', nil, 99, 'tab', function(info) return E.db.fun.lines[info[#info-1]][info[#info]] end, function(info, value) E.db.fun.lines[info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	Options.args.bottom = bottom
	bottom.args.enable = ACH:Toggle(L["Enable"], nil, 0)
	bottom.args.spacer = ACH:Spacer(1, 'full')

	bottom.args.horizontal = ACH:Group(L["Horizontal"], nil, 14, nil, function(info) return E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	bottom.args.horizontal.inline = true
	bottom.args.horizontal.args.yOffset = ACH:Range(L["yOffset"], L["This will adjust the Horizontal line's distance from the edge of the screen."], 1, { min = 0, softMin = 0, softMax = 350, max = 750, step = 1 })
	bottom.args.horizontal.args.width = ACH:Range(L["Width"], L["Determines the thickness of the line."], 3, { softMin = 2, min = 2, softMax = 50, max = 100, step = 1 })
	bottom.args.horizontal.args.spacer1 = ACH:Spacer(4, 'full')
	bottom.args.horizontal.args.borderColor = ACH:Color(L["Border Color"], nil, 14, true, nil, function(info) local t = E.db.fun.lines.bottom.horizontal[info[#info]] local d = P.fun.lines.bottom.horizontal[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.horizontal[info[#info]] = {} local t = E.db.fun.lines.bottom.horizontal[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	bottom.args.horizontal.args.backdropColor = ACH:Color(L["Backdrop Color"], nil, 14, true, nil, function(info) local t = E.db.fun.lines.bottom.horizontal[info[#info]] local d = P.fun.lines.bottom.horizontal[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.horizontal[info[#info]] = {} local t = E.db.fun.lines.bottom.horizontal[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)

	bottom.args.left = ACH:Group(L["Left"], nil, 15, nil, function(info) return E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	bottom.args.left.inline = true
	bottom.args.left.args.xOffset = ACH:Range(L["xOffset"], format(L["This will adjust the %s vertical line's distance from the edge of the screen, which determines the length of the horizontal line as well."], L["Left"]), 1, { softMin = 0, min = 0, softMax = 350, max = 750, step = 1 })
	bottom.args.left.args.length = ACH:Range(L["Length"], nil, 2, { softMin = 5, min = 2, softMax = 250, max = 500, step = 1 })
	bottom.args.left.args.width = ACH:Range(L["Width"], L["Determines the thickness of the line."], 3, { softMin = 2, min = 2, softMax = 50, max = 100, step = 1 })
	bottom.args.left.args.spacer1 = ACH:Spacer(4, 'full')
	bottom.args.left.args.header1 = ACH:Header(L["Line Color"], 15)
	bottom.args.left.args.borderColor = ACH:Color(L["Border Color"], nil, 16, true, nil, function(info) local t = E.db.fun.lines.bottom.left[info[#info]] local d = P.fun.lines.bottom.left[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.left[info[#info]] = {} local t = E.db.fun.lines.bottom.left[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	bottom.args.left.args.backdropColor = ACH:Color(L["Backdrop Color"], nil, 17, true, nil, function(info) local t = E.db.fun.lines.bottom.left[info[#info]] local d = P.fun.lines.bottom.left[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.left[info[#info]] = {} local t = E.db.fun.lines.bottom.left[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	bottom.args.left.args.header2 = ACH:Header(L["Cube Color"], 20)
	bottom.args.left.args.cubeBorderColor = ACH:Color(L["Border Color"], nil, 21, true, nil, function(info) local t = E.db.fun.lines.bottom.left.cube.borderColor local d = P.fun.lines.bottom.left.cube.borderColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.left.cube.borderColor = {} local t = E.db.fun.lines.bottom.left.cube.borderColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	bottom.args.left.args.cubeBackdropColor = ACH:Color(L["Backdrop Color"], nil, 22, true, nil, function(info) local t = E.db.fun.lines.bottom.left.cube.backdropColor local d = P.fun.lines.bottom.left.cube.backdropColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.left.cube.backdropColor = {} local t = E.db.fun.lines.bottom.left.cube.backdropColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)

	bottom.args.right = ACH:Group(L["Right"], nil, 16, nil, function(info) return E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] end, function(info, value) E.db.fun.lines[info[#info-2]][info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
	bottom.args.right.inline = true
	bottom.args.right.args.xOffset = ACH:Range(L["xOffset"], format(L["This will adjust the %s vertical line's distance from the edge of the screen, which determines the length of the horizontal line as well."], L["Right"]), 1, { min = -750, softMin = -350, softMax = 0, max = 0, step = 1 })
	bottom.args.right.args.length = ACH:Range(L["Length"], nil, 2, { softMin = 5, min = 2, softMax = 250, max = 500, step = 1 })
	bottom.args.right.args.width = ACH:Range(L["Width"], L["Determines the thickness of the line."], 3, { softMin = 2, min = 2, softMax = 50, max = 100, step = 1 })
	bottom.args.right.args.spacer1 = ACH:Spacer(4, 'full')
	bottom.args.right.args.header1 = ACH:Header(L["Line Color"], 15)
	bottom.args.right.args.borderColor = ACH:Color(L["Border Color"], nil, 16, true, nil, function(info) local t = E.db.fun.lines.bottom.right[info[#info]] local d = P.fun.lines.bottom.right[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.right[info[#info]] = {} local t = E.db.fun.lines.bottom.right[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	bottom.args.right.args.backdropColor = ACH:Color(L["Backdrop Color"], nil, 17, true, nil, function(info) local t = E.db.fun.lines.bottom.right[info[#info]] local d = P.fun.lines.bottom.right[info[#info]] return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.right[info[#info]] = {} local t = E.db.fun.lines.bottom.right[info[#info]] t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	bottom.args.right.args.header2 = ACH:Header(L["Cube Color"], 20)
	bottom.args.right.args.cubeBorderColor = ACH:Color(L["Border Color"], nil, 21, true, nil, function(info) local t = E.db.fun.lines.bottom.right.cube.borderColor local d = P.fun.lines.bottom.right.cube.borderColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.right.cube.borderColor = {} local t = E.db.fun.lines.bottom.right.cube.borderColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)
	bottom.args.right.args.cubeBackdropColor = ACH:Color(L["Backdrop Color"], nil, 22, true, nil, function(info) local t = E.db.fun.lines.bottom.right.cube.backdropColor local d = P.fun.lines.bottom.right.cube.backdropColor return t.r, t.g, t.b, t.a, d.r, d.g, d.b, d.a end, function(info, r, g, b, a) E.db.fun.lines.bottom.right.cube.backdropColor = {} local t = E.db.fun.lines.bottom.right.cube.backdropColor t.r, t.g, t.b, t.a = r, g, b, a FUN:UpdateOptions() end)

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
	Download.args.changelog = ACH:Execute(L["Changelog"], nil, 3, function() if FUN_Changelog and FUN_Changelog:IsShown() then FUN:Print('ActionBar Masks changelog is already being displayed.') else FUNCL:ToggleChangeLog() end end, nil, nil, 140)

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
