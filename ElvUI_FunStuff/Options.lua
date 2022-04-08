local E, L = unpack(ElvUI)
local FUN = E:GetModule('ElvUI_FunStuff')
local FUNCL = E:GetModule('FunStuff-Changelog')
local ACH = E.Libs.ACH

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
	local fun = ACH:Group('|cFF16C3F2Fun|rStuff', nil, 6, 'tab', nil, nil)
	E.Options.args.fun = fun

	local Options = ACH:Group(L["Options"], nil, 0, nil, function(info) return E.db.fun[info[#info-1]][info[#info]] end, function(info, value) E.db.fun[info[#info-1]][info[#info]] = value FUN:UpdateOptions() end)
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
	ACH:Group(name, desc, order, childGroups, get, set, disabled, hidden, func)
	Options.args.tukui = Tukui
	Tukui.inline = true
	Tukui.args.enable = ACH:Toggle(L["Show Tukui Bars"], nil, 0)
	Tukui.args.spacer = ACH:Spacer(1, 'full')
	Tukui.args.newProfile = ACH:Execute(L["Create New Profile"], nil, 5, function(info, value) SetupNewProfile(info, value) end, nil, nil, 200)

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
