local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local AB = E:GetModule('ActionBars')

local _G = _G
local pairs = pairs
local wipe, tinsert = wipe, tinsert

local DoEmote = DoEmote
local GetCVar, SetCVar = GetCVar, SetCVar
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS
local PlayMusic, StopMusic = PlayMusic, StopMusic
-- GLOBALS: ElvUI_StaticPopup1, ElvUI_StaticPopup1Button1, ElvUI_StanceBar

--Harlem Shake (Activate with command: /harlemshake)
--People really seemed to like this one. We got a lot of positive responses.
do
	function E:StopHarlemShake()
		E.isMassiveShaking = nil
		StopMusic()
		SetCVar('Sound_EnableAllSound', self.oldEnableAllSound)
		SetCVar('Sound_EnableMusic', self.oldEnableMusic)

		E:StopShakeHorizontal(ElvUI_StaticPopup1)
		for _, object in pairs(self.massiveShakeObjects) do
			if object then
				E:StopShake(object)
			end
		end

		if E.massiveShakeTimer then
			E:CancelTimer(E.massiveShakeTimer)
		end

		E:StaticPopup_Hide('FUN_HARLEM_SHAKE')
		wipe(self.massiveShakeObjects)
		DoEmote('Dance')
	end

	function E:DoTheHarlemShake()
		E.isMassiveShaking = true
		ElvUI_StaticPopup1Button1:Enable()

		for _, object in pairs(self.massiveShakeObjects) do
			if object and not object:IsForbidden() and object:IsShown() then
				E:Shake(object)
			end
		end

		E.massiveShakeTimer = E:ScheduleTimer('StopHarlemShake', 42.5)
	end

	function E:BeginHarlemShake()
		DoEmote('Dance')
		ElvUI_StaticPopup1Button1:Disable()
		E:ShakeHorizontal(ElvUI_StaticPopup1)
		self.oldEnableAllSound = GetCVar('Sound_EnableAllSound')
		self.oldEnableMusic = GetCVar('Sound_EnableMusic')

		SetCVar('Sound_EnableAllSound', 1)
		SetCVar('Sound_EnableMusic', 1)
		PlayMusic(E.Media.Sounds.HarlemShake)
		E:ScheduleTimer('DoTheHarlemShake', 15.5)

		self.massiveShakeObjects = {}
		tinsert(self.massiveShakeObjects, _G.GameTooltip)
		tinsert(self.massiveShakeObjects, _G.Minimap)
		tinsert(self.massiveShakeObjects, _G.ObjectiveTrackerFrame)
		tinsert(self.massiveShakeObjects, _G.LeftChatPanel)
		tinsert(self.massiveShakeObjects, _G.LeftChatToggleButton)
		tinsert(self.massiveShakeObjects, _G.RightChatPanel)
		tinsert(self.massiveShakeObjects, _G.RightChatToggleButton)
		tinsert(self.massiveShakeObjects, _G.ElvUI_HonorBarHolder)
		tinsert(self.massiveShakeObjects, _G.ElvUI_ExperienceBarHolder)
		tinsert(self.massiveShakeObjects, _G.ElvUI_ReputationBarHolder)

		for unit in pairs(UF.units) do
			tinsert(self.massiveShakeObjects, UF[unit])
		end
		for _, header in pairs(UF.headers) do
			tinsert(self.massiveShakeObjects, header)
		end

		for _, bar in pairs(AB.handledBars) do
			for i = 1, #bar.buttons do
				tinsert(self.massiveShakeObjects, bar.buttons[i])
			end
		end

		if ElvUI_StanceBar then
			for i = 1, #ElvUI_StanceBar.buttons do
				tinsert(self.massiveShakeObjects, ElvUI_StanceBar.buttons[i])
			end
		end

		for i = 1, NUM_PET_ACTION_SLOTS do
			local button = _G['PetActionButton'..i]
			if button then
				tinsert(self.massiveShakeObjects, button)
			end
		end
	end

	function E:HarlemShakeToggle()
		E:StaticPopup_Show('FUN_HARLEM_SHAKE')
	end
end
