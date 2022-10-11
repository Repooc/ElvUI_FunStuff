local E, L = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local AddOnName, Engine = ...

local FUN = E:NewModule(AddOnName, 'AceHook-3.0')
_G[AddOnName] = Engine
FUN.Version = GetAddOnMetadata('ElvUI_FunStuff', 'Version')
FUN.Configs = {}
FUN.RequiredVersion = 12.90

E.PopupDialogs.FUN_HARLEM_SHAKE = {
	text = L["ElvUI needs to perform database optimizations please be patient."],
	button1 = OKAY,
	OnAccept = function()
		if E.isMassiveShaking then
			E:StopHarlemShake()
		else
			E:BeginHarlemShake()
			return true
		end
	end,
	whileDead = 1,
}

E.PopupDialogs.FUN_CONFIG_RL = {
	text = L["You have selected an option that will need a reload before the profile is fully installed.\n\nYou can continue to finish the installer now or you can click \"Reload Now\" so the changes take effect then finish the rest of the installer after the reload.\n\nAfter the reload finishes, you need to either click \"Skip Process\" or continue with the rest of the installer until the end and click \"Finished\"."],
	button1 = L["RELOAD NOW"],
	button2 = L["HIDE"],
	OnAccept = ReloadUI,
	whileDead = 1,
	hideOnEscape = true,
	showAlert = true,
}

E.PopupDialogs.FUN_PROFILE_WARNING = {
	button1 = L["OVERWRITE"],
	button2 = L["CANCEL"],
	OnAccept = function(_, data)
		if not data or not data.layout then return end
		if data.layout == 'tukui' then
			FUN:SetupTukuiProfile(true)
			_G.PluginInstallStepComplete.message = '|cffff8000Tukui|r: |cff00FF00'..L["Profile Imported"]..'|r'
		elseif data.layout == 'hellokitty' then
			FUN:SetupHelloKitty(true)
			_G.PluginInstallStepComplete.message = '|cffDF4CBCHello Kitty|r: |cff00FF00'..L["Profile Imported"]..'|r'
		end
		_G.PluginInstallStepComplete:Show()
		_G.PluginInstallFrame.Next:Click()
	end,
	whileDead = 1,
	hideOnEscape = false,
	showAlert = true,
}

FUN.availLayouts = {
	hellokitty = {
		name = '|cffDF4CBCHello Kitty|r',
		profileName = 'Hello Kitty v'..FUN.Version,
		newProfileFunc = FUN.SetupHelloKitty,
		installMessage = '|cffDF4CBCHello Kitty|r: |cff00FF00'..L["Profile Imported"]..'|r'
	},
	tukui = {
		name = '|cffFF8000Tukui|r',
		profileName = 'Tukui v'..FUN.Version,
		newProfileFunc = FUN.SetupTukuiProfile,
		installMessage = '|cffff8000Tukui|r: |cff00FF00'..L["Profile Imported"]..'|r'
	},
}

function FUN:Print(...)
	(E.db and _G[E.db.general.messageRedirect] or _G.DEFAULT_CHAT_FRAME):AddMessage(strjoin('', '|cff1784d1[|r|cFF16C3F2Fun|rStuff|cff1784d1]|r ', ...)) -- I put DEFAULT_CHAT_FRAME as a fail safe.
end

local function GetOptions()
	for _, func in pairs(FUN.Configs) do
		func()
	end
end

local function LoadCommands()
	E:RegisterChatCommand('harlemshake', 'HarlemShakeToggle')
end

function FUN:UpdateOptions()
	FUN:UpdateDancingKittys()
	FUN:UpdateTukuiPanels()
end

local function VersionCheck()
	if E.version < FUN.RequiredVersion then
		FUN:Print(format('|cffbf0008%s|r', L["This plugin requires a higher version of ElvUI, please check for an update and reload your ui."]))
		return true
	end
end

function FUN:Initialize()
	if VersionCheck() then return end

	EP:RegisterPlugin(AddOnName, GetOptions)
	LoadCommands()

	FUN:InitializeHelloKitty()
	FUN:InitializeTukui()
	FUN:UpdateOptions()
	hooksecurefunc(E, 'UpdateDB', FUN.UpdateOptions)

	if not E.private.fun.install_complete then
		E.PluginInstaller:Queue(FUN.installTable)
	end

	if not FUNDB then
		_G.FUNDB = {}
	end
end

E.Libs.EP:HookInitialize(FUN, FUN.Initialize)
