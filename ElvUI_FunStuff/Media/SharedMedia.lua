local E = unpack(ElvUI) --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local LSM = E.Libs.LSM

local MediaKey = {
	font	= 'Fonts',
	sound	= 'Sounds',
	texture	= 'Textures'
}

local MediaPath = {
	font	= [[Interface\AddOns\ElvUI_FunStuff\Media\Fonts\]],
	sound	= [[Interface\AddOns\ElvUI_FunStuff\Media\Sounds\]],
	texture	= [[Interface\AddOns\ElvUI_FunStuff\Media\Textures\]]
}

local function AddMedia(Type, File, Name, CustomType)
	local path = MediaPath[Type]
	if path then
		local key = File:gsub('%.%w-$','')
		local file = path .. File

		local pathKey = MediaKey[Type]
		if pathKey then E.Media[pathKey][key] = file end

		if Name then -- Register to LSM
			local nameKey = (Name == true and key) or Name
			if type(CustomType) == 'table' then
				for _, name in ipairs(CustomType) do
					LSM:Register(name, nameKey, file)
				end
			else
				LSM:Register(CustomType or Type, nameKey, file)
			end
		end
	end
end

AddMedia('sound', 'HelloKitty.ogg')
AddMedia('sound', 'HarlemShake.ogg')

AddMedia('texture', 'HelloKitty')
AddMedia('texture', 'HelloKittyChat')
AddMedia('texture', 'Tukui', 'Tukui Style', 'statusbar')

LSM:Register('font','Tukui Actionbars', MediaPath.font..'Arial.ttf', LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western)
LSM:Register('font','Tukui Unitframes', MediaPath.font..'BigNoodleTitling.ttf')
