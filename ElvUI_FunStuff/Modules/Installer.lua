local E, L = unpack(ElvUI)
local FUN = E:GetModule('ElvUI_FunStuff')
local PI = E:GetModule('PluginInstaller')

local type = type

local temp = {}

local function InstallComplete()
	E.private.fun.install_complete = FUN.version
	if GetCVarBool('Sound_EnableMusic') then StopMusic() end
	ReloadUI()
end

-- Adds the ability for StepTitles table to have a function to return dynamic text like we do in this plugin (Look at step 3 for an example.)
local function SetPage()
	local f = _G.PluginInstallFrame
	if f.StepTitles then
		for i = 1, #f.side.Lines do
			f.side.Lines[i].text:SetText(type(f.StepTitles[i]) == 'function' and f.StepTitles[i]() or f.StepTitles[i])
		end
	end
end

if PI.SetPage then
	hooksecurefunc(PI, 'SetPage', SetPage)
end

local function profileCheck(data)
	if not data then _G.PluginInstallFrame.Prev:Click() return end
	local tempName = FUN.availLayouts[data.layout].profileName
	local currentProfile = E.data:GetCurrentProfile()
	local warning = false

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
		E:StaticPopup_Show('FUN_PROFILE_WARNING', nil, nil, temp)
	else
		FUN.availLayouts[data.layout].newProfileFunc(true)
		_G.PluginInstallStepComplete.message = FUN.availLayouts[data.layout].installMessage
		_G.PluginInstallStepComplete:Show()
		_G.PluginInstallFrame.Next:Click()
	end
end

FUN.installTable = {
	Name = '|cff1784d1ElvUI|r |cFF16C3F2Fun|rStuff',
	Title = '|cff1784d1ElvUI|r |cFF16C3F2Fun|rStuff',
	tutorialImage = '',
	tutorialImageSize = {512, 128},
	tutorialImagePoint = {0, -35},
	Pages = {
		[1] = function()
			_G.PluginInstallTutorialImage:SetTexture('')
			_G.PluginInstallFrame.SubTitle:SetText(strjoin('', '|cffFF3333', L["Read Before Clicking!!!"]))
			_G.PluginInstallFrame.Desc1:SetText(strjoin('', '|cffFFD100', L["FUNSTUFF_INSTALL_WELCOME"]))
			_G.PluginInstallFrame.Desc2:SetText(strjoin('', '|cffFFD100', L["If you choose to not import any of the profiles for now, you may click the \"Skip Process\" button to close the installation wizard."]))
			_G.PluginInstallFrame.Desc4:SetText(strjoin('', '|cffFFD100', L["Please press the continue button to go onto the next step."]))

			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
			_G.PluginInstallFrame.Option1:SetText(L["Skip Process"])
			_G.PluginInstallFrame.Option1:Size(160, 30)
			_G.PluginInstallFrame.Option1:ClearAllPoints()
			_G.PluginInstallFrame.Option1:Point('CENTER', _G.PluginInstallFrame.tutorialImage, 0, 0)
		end,
		[2] = function()
			wipe(temp)
			_G.PluginInstallTutorialImage:SetTexture('')
			_G.PluginInstallFrame.SubTitle:SetText(strjoin('', '|cffFF3333', L["Read Before Clicking!!!"]))
			_G.PluginInstallFrame.Desc1:SetText(strjoin('', '|cffFFD100', L["You can choose between |cffFF8000\"Tukui\"|r and |cff1784d1\"Hello Kitty\"|r layouts."]))
			_G.PluginInstallFrame.Desc3:SetText(strjoin('', '|cffFFD100', L["Importance: |cffD3CF00Medium|r"]))

			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetText('|cffDF4CBCHello Kitty|r')
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function()
				temp.layout = 'hellokitty'
				_G.PluginInstallFrame.Next:Click()
			end)

			_G.PluginInstallFrame.Option2:Show()
			_G.PluginInstallFrame.Option2:SetText('|cffFF8000Tukui|r')
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function()
				temp.layout = 'tukui'
				_G.PluginInstallFrame.Next:Click()
			end)
			_G.PluginInstallFrame.Option1:Size(200, 30)
			_G.PluginInstallFrame.Option1:ClearAllPoints()
			_G.PluginInstallFrame.Option1:Point('CENTER', _G.PluginInstallFrame.tutorialImage, 'CENTER', 0, 17)
			_G.PluginInstallFrame.Option2:Size(200, 30)
			_G.PluginInstallFrame.Option2:ClearAllPoints()
			_G.PluginInstallFrame.Option2:Point('TOP', _G.PluginInstallFrame.Option1, 'BOTTOM', 0, -4)
		end,
		[3] = function()
			if temp.layout == 'hellokitty' then
				_G.PluginInstallTutorialImage:SetTexture([[Interface\AddOns\ElvUI_FunStuff\Media\Textures\HelloKittyBanner]])
				_G.PluginInstallFrame.Option1:Show()
				_G.PluginInstallFrame.Option2:Show()
			elseif temp.layout == 'tukui' then
				_G.PluginInstallTutorialImage:SetTexture('')
				_G.PluginInstallFrame.Option1:Show()
				_G.PluginInstallFrame.Option2:Hide()
			else
				_G.PluginInstallTutorialImage:SetTexture('')
				_G.PluginInstallFrame.Option1:Hide()
				_G.PluginInstallFrame.Option2:Hide()
			end
			_G.PluginInstallFrame.Option1:SetText(L["Create New Profile"])

			_G.PluginInstallFrame.SubTitle:SetText(strjoin('', '|cffFF3333', L["Read Before Clicking!!!"]))
			if temp.layout and FUN.availLayouts[temp.layout] then
				_G.PluginInstallFrame.Desc1:SetText(strjoin('', '|cffFFD100', format(L["You can choose to \"|cff1784d1Create New Profile|r\" which will create a new profile labeled as \"%s v|cff1784d1%s|r\"."], FUN.availLayouts[temp.layout].name, FUN.version)))
			else
				_G.PluginInstallFrame.Desc1:SetText(strjoin('', '|cffFFD100', L["You can click the previous button below to go back and choose a layout/theme, or click continue without importing one."]))
			end
			_G.PluginInstallFrame.Desc3:SetText(strjoin('', '|cffFFD100', L["Importance: |cffFF3333High|r"]))

			_G.PluginInstallFrame.Option1:SetScript('OnClick', function() profileCheck(temp) end)
			_G.PluginInstallFrame.Option2:SetText(L["Apply To Current Profile"])
			_G.PluginInstallFrame.Option2:SetScript('OnClick', function()
				if temp.layout == 'hellokitty' then
					FUN:SetupHelloKitty()
					_G.PluginInstallStepComplete.message = '|cffDF4CBCHello Kitty|r: |cff00FF00'..L["Profile Updated"]..'|r'
					_G.PluginInstallStepComplete:Show()
					_G.PluginInstallFrame.Next:Click()
				end
			end)

			_G.PluginInstallFrame.Option1:Size(200, 30)
			_G.PluginInstallFrame.Option1:ClearAllPoints()
			_G.PluginInstallFrame.Option1:Point('CENTER', _G.PluginInstallFrame.tutorialImage, 'CENTER', 0, 17)
			_G.PluginInstallFrame.Option2:Size(200, 30)
			_G.PluginInstallFrame.Option2:ClearAllPoints()
			_G.PluginInstallFrame.Option2:Point('TOP', _G.PluginInstallFrame.Option1, 'BOTTOM', 0, -4)
		end,
		[4] = function()
			_G.PluginInstallTutorialImage:SetTexture('')
			_G.PluginInstallFrame.SubTitle:SetText(strjoin('', '|cffFF3333', L["Read Before Clicking!!!"]))
			_G.PluginInstallFrame.Desc1:SetText(strjoin('', '|cffFFD100', L["If you decided to not create a new profile or apply the whole Hello Kitty theme, you can always have just the dancing kittys instead!"]))
			_G.PluginInstallFrame.Desc2:SetText(strjoin('', '|cffFFD100', L["If you are in a rush for some dancing kittys and don't feel like going through the config, the button below will allow you to quickly enable them so you can get back to what you were doing!"]))
			_G.PluginInstallFrame.Desc3:SetText(L["Importance: |cFF33FF33Low|r"])

			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetText(L["Toggle Dancing Kittys!"])
			_G.PluginInstallFrame.Option1:SetScript('OnClick', function()
				if E.db.fun.hellokitty.enable then
					E.db.fun.hellokitty.enable = false
				else
					E.db.fun.hellokitty.enable = true
				end
				FUN:UpdateDancingKittys()
				_G.PluginInstallStepComplete.message = format('|cffDF4CBCHello Kitty|r: |cff%s|r', E.db.fun.hellokitty.enable and '33FF33'..L["Enabled"] or 'FF3333'..L["Disabled"])
				_G.PluginInstallStepComplete:Show()
			end)
			_G.PluginInstallFrame.Option1:ClearAllPoints()
			_G.PluginInstallFrame.Option1:Point('CENTER', _G.PluginInstallFrame.tutorialImage, 0, 0)
		end,
		[5] = function()
			_G.PluginInstallFrame.SubTitle:SetText(L["Installation Complete"])
			_G.PluginInstallFrame.Desc1:SetText(L["You are now finished with the installation process. If you are in need of technical support please visit https://github.com/Repooc/ElvUI_FunStuff."])
			_G.PluginInstallFrame.Desc2:SetText(L["Please click the button below so you can setup variables and ReloadUI."])

			_G.PluginInstallFrame.Option1:Show()
			_G.PluginInstallFrame.Option1:SetScript('OnClick', InstallComplete)
			_G.PluginInstallFrame.Option1:SetText(L["Finished"])
		end,
	},
	StepTitles = {
		[1] = START,
		[2] = L["Choose Layout"],
		[3] = function() return temp.layout == 'hellokitty' and L["Setup Kitty Layout"] or temp.layout == 'tukui' and L["Setup Tukui Layout"] or L["Configure Layout"] end,
		[4] = L["Misc Options"],
		[5] = L["Finished"],
	},
	StepTitlesColor = {1,0.82,0},
}
