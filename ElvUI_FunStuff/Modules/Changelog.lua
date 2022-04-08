local E = unpack(ElvUI)
local FUN = E:GetModule('ElvUI_FunStuff')
local S = E:GetModule('Skins')

local module = E:NewModule('FunStuff-Changelog', 'AceEvent-3.0', 'AceTimer-3.0')
local format, gsub, find = string.format, string.gsub, string.find

local ChangelogTBL = {
	'v1.00 4/??/2022',
		'• Initial Release',
		-- "• ''",
}

local URL_PATTERNS = {
	'^(%a[%w+.-]+://%S+)',
	'%f[%S](%a[%w+.-]+://%S+)',
	'^(www%.[-%w_%%]+%.(%a%a+))',
	'%f[%S](www%.[-%w_%%]+%.(%a%a+))',
	'(%S+@[%w_.-%%]+%.(%a%a+))',
}

local function formatURL(url)
	url = '|cff'..'149bfd'..'|Hurl:'..url..'|h['..url..']|h|r ';
	return url
end

local function ModifiedLine(string)
	local newString = string
	for _, v in pairs(URL_PATTERNS) do
		if find(string, v) then
			newString = gsub(string, v, formatURL('%1'))
		end
	end
	return newString
end

local changelogLines = {}
local function GetNumLines()
   local index = 1
   for i = 1, #ChangelogTBL do
		local line = ModifiedLine(ChangelogTBL[i])
		changelogLines[index] = line

		index = index + 1
   end
   return index - 1
end

function module:CountDown()
	module.time = module.time - 1

	if module.time == 0 then
		module:CancelAllTimers()
		FUNChangelog.close:Enable()
		FUNChangelog.close:SetText(CLOSE)
	else
		FUNChangelog.close:Disable()
		FUNChangelog.close:SetText(CLOSE..format(' (%s)', module.time))
	end
end

function module:CreateChangelog()
	local Size = 500
	local frame = CreateFrame('Frame', 'FUNChangelog', E.UIParent)
	tinsert(_G.UISpecialFrames, 'FUNChangelog')
	frame:SetTemplate('Transparent')
	frame:Size(Size, Size)
	frame:Point('CENTER', 0, 0)
	frame:Hide()
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetResizable(true)
	frame:SetMinResize(350, 100)
	frame:SetScript('OnMouseDown', function(changelog, button)
		if button == 'LeftButton' and not changelog.isMoving then
			changelog:StartMoving()
			changelog.isMoving = true
		elseif button == 'RightButton' and not changelog.isSizing then
			changelog:StartSizing()
			changelog.isSizing = true
		end
	end)
	frame:SetScript('OnMouseUp', function(changelog, button)
		if button == 'LeftButton' and changelog.isMoving then
			changelog:StopMovingOrSizing()
			changelog.isMoving = false
		elseif button == 'RightButton' and changelog.isSizing then
			changelog:StopMovingOrSizing()
			changelog.isSizing = false
		end
	end)
	frame:SetScript('OnHide', function(changelog)
		if changelog.isMoving or changelog.isSizing then
			changelog:StopMovingOrSizing()
			changelog.isMoving = false
			changelog.isSizing = false
		end
	end)
	frame:SetFrameStrata('DIALOG')

	local header = CreateFrame('Frame', nil, frame, 'BackdropTemplate')
	header:Point('TOPLEFT', frame, 0, 0)
	header:Point('TOPRIGHT', frame, 0, 0)
	header:Point('TOP')
	header:SetHeight(25)
	header:SetTemplate('Transparent')
	header.text = header:CreateFontString(nil, 'OVERLAY')
	header.text:FontTemplate(nil, 15, 'OUTLINE')
	header.text:SetHeight(header.text:GetStringHeight()+30)
	header.text:SetText('ActionBar Masks - Changelog '..format('|cff00c0fa%s|r', FUN.Version))
	header.text:SetTextColor(1, 0.8, 0)
	header.text:Point('CENTER', header, 0, -1)

	local footer = CreateFrame('Frame', nil, frame)
	footer:Point('BOTTOMLEFT', frame, 0, 0)
	footer:Point('BOTTOMRIGHT', frame, 0, 0)
	footer:Point('BOTTOM')
	footer:SetHeight(30)
	footer:SetTemplate('Transparent')

	local close = CreateFrame('Button', nil, footer, 'UIPanelButtonTemplate, BackdropTemplate')
	close:Point('CENTER')
	close:SetText(CLOSE)
	close:Size(80, 20)
	close:SetScript('OnClick', function()
		_G.FUNDB['Version'] = FUN.Version
		frame:Hide()
	end)
	S:HandleButton(close)
	close:Disable()
	frame.close = close

	local scrollArea = CreateFrame('ScrollFrame', 'FUNChangelogScrollFrame', frame, 'UIPanelScrollFrameTemplate')
	scrollArea:Point('TOPLEFT', header, 'BOTTOMLEFT', 8, -3)
	scrollArea:Point('BOTTOMRIGHT', footer, 'TOPRIGHT', -25, 3)
	S:HandleScrollBar(_G.FUNChangelogScrollFrameScrollBar, nil, nil, 'Transparent')
	scrollArea:HookScript('OnVerticalScroll', function(scroll, offset)
		_G.FUNChangelogFrameEditBox:SetHitRectInsets(0, 0, offset, (_G.FUNChangelogFrameEditBox:GetHeight() - offset - scroll:GetHeight()))
	end)

	local editBox = CreateFrame('EditBox', 'FUNChangelogFrameEditBox', frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject('ChatFontNormal')
	editBox:SetTextColor(1, 0.8, 0)
	editBox:Width(scrollArea:GetWidth())
	editBox:Height(scrollArea:GetHeight())
	-- editBox:SetScript('OnEscapePressed', function() _G.FUNChangelog:Hide() end)
	scrollArea:SetScrollChild(editBox)
end

function module:ToggleChangeLog()
	local lineCt = GetNumLines(frame)
	local text = table.concat(changelogLines, ' \n', 1, lineCt)
	_G.FUNChangelogFrameEditBox:SetText(text)

	PlaySound(888)

	local fadeInfo = {}
	fadeInfo.mode = 'IN'
	fadeInfo.timeToFade = 0.5
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = 1
	E:UIFrameFade(FUNChangelog, fadeInfo)

	module.time = 6
	module:CancelAllTimers()
	module:CountDown()
	module:ScheduleRepeatingTimer('CountDown', 1)
end

function module:CheckVersion()
	if not InCombatLockdown() then
		if not FUNDB['Version'] or (FUNDB['Version'] and FUNDB['Version'] ~= FUN.Version) then
			module:ToggleChangeLog()
		end
	else
		module:RegisterEvent('PLAYER_REGEN_ENABLED', function(event)
			module:CheckVersion()
			module:UnregisterEvent(event)
		end)
	end

end

function module:Initialize()
	if not FUNChangelog then
		module:CreateChangelog()
	end
	module:RegisterEvent('PLAYER_REGEN_DISABLED', function()
		if FUNChangelog and not FUNChangelog:IsVisible() then return end
		module:RegisterEvent('PLAYER_REGEN_ENABLED', function(event) FUNChangelog:Show() module:UnregisterEvent(event) end)
		FUNChangelog:Hide()
	end)
	E:Delay(6, function() module:CheckVersion() end)
end

E:RegisterModule(module:GetName())
