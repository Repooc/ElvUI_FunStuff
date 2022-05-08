local E, _, _, P = unpack(ElvUI)
local FUN = E:GetModule('ElvUI_FunStuff')

function FUN:SetupTukuiProfile(newProfile)
	if newProfile then
		E.data:SetProfile('Tukui v'..FUN.Version)
		E.db.convertPages = true
	end

	E.db.fun.tukui.enable = true
	E.db.fun.hellokitty.enable = false

	--* Private
	E.private.general.glossTex = 'Tukui Style'
	E.private.general.normTex = 'Tukui Style'
	E.private.general.pixelPerfect = false

	--* General
	E.db.general.backdropcolor.b = 0.10980392156863
	E.db.general.backdropcolor.g = 0.10980392156863
	E.db.general.backdropcolor.r = 0.10980392156863
	E.db.general.backdropfadecolor.a = 0.80000001192093
	E.db.general.backdropfadecolor.b = 0.058823529411765
	E.db.general.backdropfadecolor.g = 0.058823529411765
	E.db.general.backdropfadecolor.r = 0.058823529411765
	E.db.general.bordercolor.r = 0
	E.db.general.bordercolor.g = 0
	E.db.general.bordercolor.b = 0
	E.db.general.bottomPanel = false
	E.db.general.minimap.size = 160

	--* Auras
	E.db.auras.buffs.horizontalSpacing = 4
	E.db.auras.buffs.size = 28
	E.db.auras.buffs.timeFont = 'Tukui Actionbars'
	E.db.auras.buffs.timeFontOutline = 'OUTLINE'
	E.db.auras.buffs.timeFontSize = 10
	E.db.auras.debuffs.size = 30
	E.db.auras.debuffs.timeFont = 'Tukui Actionbars'
	E.db.auras.debuffs.timeFontOutline = 'OUTLINE'
	E.db.auras.debuffs.timeFontSize = 10

	--* Bag
	E.db.bags.bagWidth = 412

	--* Chat
	E.db.chat.hideChatToggles = true
	E.db.chat.panelBackdrop = 'HIDEBOTH'
	E.db.chat.panelBackdropNameLeft = ''
	E.db.chat.panelBackdropNameRight = ''

	--* Databars
	E.db.databars.experience.enable = true
	E.db.databars.experience.height = 150
	E.db.databars.experience.hideAtMaxLevel = false
	E.db.databars.experience.orientation = 'VERTICAL'
	E.db.databars.experience.width = 8
	E.db.databars.honor.enable = true
	E.db.databars.honor.height = 150
	E.db.databars.honor.orientation = 'VERTICAL'
	E.db.databars.honor.width = 8
	E.db.databars.reputation.enable = true
	E.db.databars.reputation.height = 184
	E.db.databars.reputation.orientation = 'VERTICAL'
	E.db.databars.reputation.width = 8

	--* Datatexts
	E.db.datatexts.font = 'Expressway'
	E.db.datatexts.fontOutline = 'OUTLINE'
	E.db.datatexts.fontSize = 12
	E.db.datatexts.panels.MinimapPanel.numPoints = 1
	E.db.datatexts.panels.MinimapPanel[1] = 'Time'
	E.db.datatexts.panels.RightChatDataPanel[2] = 'Volume'

	--* Unitframe (General)
	E.db.unitframe.colors = E:CopyTable({}, P.unitframe.colors)
	E.db.unitframe.colors.healthclass = true
	E.db.unitframe.colors.transparentHealth = false
	if locale == 'ruRU' then
		E.db.unitframe.font = 'PT Sans Narrow'
	else
		E.db.unitframe.font = 'Tukui Unitframes'
	end
	E.db.unitframe.fontOutline = 'OUTLINE'
	E.db.unitframe.fontSize = 14
	E.db.unitframe.smartRaidFilter = false
	E.db.unitframe.statusbar = 'Tukui Style'

	--* Player
	E.db.unitframe.units.player.RestIcon.anchorPoint = 'LEFT'
	E.db.unitframe.units.player.RestIcon.texture = 'Resting1'
	E.db.unitframe.units.player.RestIcon.xOffset = 11
	E.db.unitframe.units.player.RestIcon.yOffset = 0
	E.db.unitframe.units.player.aurabar.enable = false
	E.db.unitframe.units.player.buffs.attachTo = 'FRAME'
	E.db.unitframe.units.player.buffs.enable = true
	E.db.unitframe.units.player.castbar.overlayOnFrame = 'InfoPanel'
	E.db.unitframe.units.player.castbar.width = 250
	E.db.unitframe.units.player.debuffs.attachTo = 'BUFFS'
	E.db.unitframe.units.player.health.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.player.health.position = 'RIGHT'
	E.db.unitframe.units.player.height = 34
	E.db.unitframe.units.player.infoPanel.enable = true
	E.db.unitframe.units.player.infoPanel.height = 21
	E.db.unitframe.units.player.name.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.player.name.position = 'LEFT'
	E.db.unitframe.units.player.name.text_format = '[difficultycolor][level] [classcolor][name:medium]'
	E.db.unitframe.units.player.power.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.player.power.height = 8
	E.db.unitframe.units.player.power.text_format = ''
	E.db.unitframe.units.player.smartAuraPosition = 'FLUID_DEBUFFS_ON_BUFFS'
	E.db.unitframe.units.player.width = 250

	--* Pet
	E.db.unitframe.units.pet.buffs.anchorPoint = 'TOPLEFT'
	E.db.unitframe.units.pet.buffs.enable = true
	E.db.unitframe.units.pet.debuffs.anchorPoint = 'TOPLEFT'
	E.db.unitframe.units.pet.debuffs.attachTo = 'BUFFS'
	E.db.unitframe.units.pet.debuffs.enable = true
	E.db.unitframe.units.pet.debuffs.growthX = 'RIGHT'
	E.db.unitframe.units.pet.health.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.pet.health.text_format = '[healthcolor][health:current:shortvalue]'
	E.db.unitframe.units.pet.health.yOffset = 1
	E.db.unitframe.units.pet.height = 20
	E.db.unitframe.units.pet.infoPanel.enable = true
	E.db.unitframe.units.pet.infoPanel.height = 17
	E.db.unitframe.units.pet.name.text_format = ''
	E.db.unitframe.units.pet.power.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.pet.power.height = 7
	E.db.unitframe.units.pet.power.text_format = '[powercolor][perpp]'
	E.db.unitframe.units.pet.power.yOffset = 1
	E.db.unitframe.units.pet.smartAuraPosition = 'FLUID_DEBUFFS_ON_BUFFS'

	--* Target
	E.db.unitframe.units.target.aurabar.enable = false
	E.db.unitframe.units.target.buffs.anchorPoint = 'TOPLEFT'
	E.db.unitframe.units.target.buffs.growthX = 'RIGHT'
	E.db.unitframe.units.target.castbar.overlayOnFrame = 'InfoPanel'
	E.db.unitframe.units.target.castbar.width = 250
	E.db.unitframe.units.target.debuffs.anchorPoint = 'TOPLEFT'
	E.db.unitframe.units.target.debuffs.growthX = 'RIGHT'
	E.db.unitframe.units.target.health.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.target.height = 34
	E.db.unitframe.units.target.infoPanel.enable = true
	E.db.unitframe.units.target.infoPanel.height = 21
	E.db.unitframe.units.target.name.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.target.name.position = 'LEFT'
	E.db.unitframe.units.target.name.text_format = '[difficultycolor][level] [classcolor][name:medium]  [shortclassification]'
	E.db.unitframe.units.target.power.height = 8
	E.db.unitframe.units.target.power.text_format = ''
	E.db.unitframe.units.target.smartAuraPosition = 'FLUID_DEBUFFS_ON_BUFFS'
	E.db.unitframe.units.target.width = 250

	--* TargetTarget
	E.db.unitframe.units.targettarget.buffs.anchorPoint = 'TOPLEFT'
	E.db.unitframe.units.targettarget.buffs.enable = true
	E.db.unitframe.units.targettarget.debuffs.anchorPoint = 'TOPLEFT'
	E.db.unitframe.units.targettarget.debuffs.growthX = 'RIGHT'
	E.db.unitframe.units.targettarget.height = 20
	E.db.unitframe.units.targettarget.infoPanel.enable = true
	E.db.unitframe.units.targettarget.infoPanel.height = 17
	E.db.unitframe.units.targettarget.name.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.targettarget.power.enable = false
	E.db.unitframe.units.targettarget.power.height = 8
	E.db.unitframe.units.targettarget.smartAuraPosition = 'FLUID_DEBUFFS_ON_BUFFS'

	--* Party
	E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT'
	E.db.unitframe.units.party.buffs.enable = true
	E.db.unitframe.units.party.buffs.yOffset = 2
	E.db.unitframe.units.party.castbar.enable = true
	E.db.unitframe.units.party.castbar.overlayOnFrame = 'InfoPanel'
	E.db.unitframe.units.party.debuffs.attachTo = 'HEALTH'
	E.db.unitframe.units.party.debuffs.sizeOverride = 40
	E.db.unitframe.units.party.debuffs.xOffset = 4
	E.db.unitframe.units.party.debuffs.yOffset = -1
	E.db.unitframe.units.party.health.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.party.health.position = 'RIGHT'
	E.db.unitframe.units.party.health.text_format = '[healthcolor][health:current:shortvalue]'
	E.db.unitframe.units.party.height = 45
	E.db.unitframe.units.party.infoPanel.enable = true
	E.db.unitframe.units.party.infoPanel.height = 21
	E.db.unitframe.units.party.name.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.party.name.position = 'LEFT'
	E.db.unitframe.units.party.name.text_format = '[difficultycolor][smartlevel] [classcolor][name:medium]  [shortclassification]'
	E.db.unitframe.units.party.power.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.party.power.text_format = ''
	E.db.unitframe.units.party.rdebuffs.font = 'Tukui Actionbars'
	E.db.unitframe.units.party.rdebuffs.fontOutline = 'OUTLINE'
	E.db.unitframe.units.party.rdebuffs.fontSize = 11
	E.db.unitframe.units.party.rdebuffs.size = 32
	E.db.unitframe.units.party.rdebuffs.stack.xOffset = 1
	E.db.unitframe.units.party.rdebuffs.yOffset = 30
	E.db.unitframe.units.party.verticalSpacing = 39
	E.db.unitframe.units.party.width = 250

	--* Raid
	E.db.unitframe.units.raid['customTexts'] = {
		['Names'] = {
			attachTextTo = 'InfoPanel',
			enable = true,
			font = 'Tukui Unitframes',
			fontOutline = 'OUTLINE',
			justifyH = 'LEFT',
			size = 13,
			text_format = '[difficultycolor][smartlevel< ][classcolor][name:medium]',
			xOffset = 0,
			yOffset = 0,
		}
	}
	E.db.unitframe.units.raid.health.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.raid.health.position = 'RIGHT'
	E.db.unitframe.units.raid.height = 38
	E.db.unitframe.units.raid.infoPanel.enable = true
	E.db.unitframe.units.raid.infoPanel.height = 13
	E.db.unitframe.units.raid.name.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.raid.name.text_format = ''
	E.db.unitframe.units.raid.power.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.raid.rdebuffs.font = 'Tukui Actionbars'
	E.db.unitframe.units.raid.rdebuffs.fontOutline = 'OUTLINE'
	E.db.unitframe.units.raid.rdebuffs.fontSize = 11
	E.db.unitframe.units.raid.rdebuffs.size = 22
	E.db.unitframe.units.raid.rdebuffs.yOffset = 22
	E.db.unitframe.units.raid.roleIcon.position = 'RIGHT'
	E.db.unitframe.units.raid.width = 95

	--* Raid40
	E.db.unitframe.units.raid40['customTexts'] = {
		['Names'] = {
			attachTextTo = 'InfoPanel',
			enable = true,
			font = 'Tukui Unitframes',
			fontOutline = 'OUTLINE',
			justifyH = 'LEFT',
			size = 13,
			text_format = '[difficultycolor][smartlevel< ][classcolor][name:medium]',
			xOffset = 0,
			yOffset = 0,
		}
	}
	E.db.unitframe.units.raid40.health.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.raid40.health.position = 'RIGHT'
	E.db.unitframe.units.raid40.height = 30
	E.db.unitframe.units.raid40.horizontalSpacing = 2
	E.db.unitframe.units.raid40.infoPanel.enable = true
	E.db.unitframe.units.raid40.infoPanel.height = 13
	E.db.unitframe.units.raid40.name.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.raid40.name.text_format = ''
	E.db.unitframe.units.raid40.rdebuffs.enable = true
	E.db.unitframe.units.raid40.rdebuffs.font = 'Tukui Actionbars'
	E.db.unitframe.units.raid40.rdebuffs.fontOutline = 'OUTLINE'
	E.db.unitframe.units.raid40.rdebuffs.fontSize = 11
	E.db.unitframe.units.raid40.rdebuffs.size = 22
	E.db.unitframe.units.raid40.rdebuffs.yOffset = 16
	E.db.unitframe.units.raid40.roleIcon.enable = true
	E.db.unitframe.units.raid40.roleIcon.position = 'RIGHT'
	E.db.unitframe.units.raid40.verticalSpacing = 2
	E.db.unitframe.units.raid40.width = 95

	--* Focus
	E.db.unitframe.units.focus.castbar.overlayOnFrame = 'Power'
	E.db.unitframe.units.focus.debuffs.anchorPoint = 'BOTTOMLEFT'
	E.db.unitframe.units.focus.debuffs.growthX = 'RIGHT'
	E.db.unitframe.units.focus.debuffs.perrow = 9
	E.db.unitframe.units.focus.debuffs.sizeOverride = 20
	E.db.unitframe.units.focus.debuffs.yOffset = -2
	E.db.unitframe.units.focus.health.position = 'TOPRIGHT'
	E.db.unitframe.units.focus.health.text_format = '[healthcolor][perhp<%]'
	E.db.unitframe.units.focus.health.xOffset = 2
	E.db.unitframe.units.focus.health.yOffset = 19
	E.db.unitframe.units.focus.height = 24
	E.db.unitframe.units.focus.name.position = 'TOPLEFT'
	E.db.unitframe.units.focus.name.text_format = '[difficultycolor][level][shortclassification] [classcolor][name:abbrev:long]'
	E.db.unitframe.units.focus.name.yOffset = 19
	E.db.unitframe.units.focus.power.height = 7

	--* FocusTarget
	E.db.unitframe.units.focustarget.debuffs.anchorPoint = 'BOTTOMLEFT'
	E.db.unitframe.units.focustarget.debuffs.enable = true
	E.db.unitframe.units.focustarget.debuffs.growthX = 'RIGHT'
	E.db.unitframe.units.focustarget.debuffs.perrow = 9
	E.db.unitframe.units.focustarget.debuffs.sizeOverride = 20
	E.db.unitframe.units.focustarget.debuffs.yOffset = -2
	E.db.unitframe.units.focustarget.enable = true
	E.db.unitframe.units.focustarget.health.position = 'TOPRIGHT'
	E.db.unitframe.units.focustarget.health.text_format = '[healthcolor][perhp<%]'
	E.db.unitframe.units.focustarget.health.xOffset = 2
	E.db.unitframe.units.focustarget.health.yOffset = 19
	E.db.unitframe.units.focustarget.height = 24
	E.db.unitframe.units.focustarget.name.position = 'TOPLEFT'
	E.db.unitframe.units.focustarget.name.text_format = '[difficultycolor][level][shortclassification] [classcolor][name:medium]'
	E.db.unitframe.units.focustarget.name.yOffset = 19
	E.db.unitframe.units.focustarget.power.height = 7

	--* Boss
	E.db.unitframe.units.boss.buffs.anchorPoint = 'TOPLEFT'
	E.db.unitframe.units.boss.buffs.attachTo = 'HEALTH'
	E.db.unitframe.units.boss.buffs.growthX = 'LEFT'
	E.db.unitframe.units.boss.buffs.growthY = 'DOWN'
	E.db.unitframe.units.boss.buffs.sizeOverride = 27
	E.db.unitframe.units.boss.buffs.xOffset = -28
	E.db.unitframe.units.boss.buffs.yOffset = -26
	E.db.unitframe.units.boss.debuffs.anchorPoint = 'BOTTOMLEFT'
	E.db.unitframe.units.boss.debuffs.attachTo = 'BUFFS'
	E.db.unitframe.units.boss.debuffs.growthX = 'LEFT'
	E.db.unitframe.units.boss.debuffs.growthY = 'DOWN'
	E.db.unitframe.units.boss.debuffs.sizeOverride = 27
	E.db.unitframe.units.boss.debuffs.yOffset = -4
	E.db.unitframe.units.boss.health.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.boss.health.position = 'RIGHT'
	E.db.unitframe.units.boss.height = 40
	E.db.unitframe.units.boss.infoPanel.enable = true
	E.db.unitframe.units.boss.infoPanel.height = 18
	E.db.unitframe.units.boss.name.attachTextTo = 'InfoPanel'
	E.db.unitframe.units.boss.name.position = 'LEFT'
	E.db.unitframe.units.boss.power.enable = false
	E.db.unitframe.units.boss.power.height = 7
	E.db.unitframe.units.boss.smartAuraPosition = 'FLUID_DEBUFFS_ON_BUFFS'
	E.db.unitframe.units.boss.width = 225

	--* Actionbars
	E.db.actionbar.font = 'Tukui Actionbars'
	E.db.actionbar.fontSize = 11
	E.db.actionbar.fontOutline = 'OUTLINE'
	for i = 1, 10 do
		if i >= 1 and i <= 3 then
			E.db.actionbar['bar'..i].enabled = true
			E.db.actionbar['bar'..i].buttonsPerRow = 6
		else
			if i ~= 4 then
				E.db.actionbar['bar'..i].buttonsPerRow = 6
				E.db.actionbar['bar'..i].enabled = false
			end
		end
		if i == 4 then
			E.db.actionbar['bar'..i].point = 'TOPRIGHT'
		else
			E.db.actionbar['bar'..i].point = 'TOPLEFT'
		end

		E.db.actionbar['bar'..i].backdrop = true
		E.db.actionbar['bar'..i].buttons = 12
		E.db.actionbar['bar'..i].buttonSpacing = 4
		E.db.actionbar['bar'..i].backdropSpacing = 5

	end
	E.db.actionbar.bar4.enabled = true
	E.db.actionbar.barPet.backdropSpacing = 5

	--* Nameplates (General)
	E.db.nameplates.filters.ElvUI_Target.triggers.enable = false
	E.db.nameplates.plateSize.enemyHeight = 35
	E.db.nameplates.plateSize.enemyWidth = 128
	E.db.nameplates.statusbar = 'Tukui Style'

	--* Enemy NPC
	E.db.nameplates.units.ENEMY_NPC.buffs.xOffset = -1
	E.db.nameplates.units.ENEMY_NPC.buffs.yOffset = 10
	E.db.nameplates.units.ENEMY_NPC.castbar.font = 'Expressway'
	E.db.nameplates.units.ENEMY_NPC.castbar.iconOffsetY = -1
	E.db.nameplates.units.ENEMY_NPC.health.height = 20
	E.db.nameplates.units.ENEMY_NPC.health.text.font = 'Expressway'
	E.db.nameplates.units.ENEMY_NPC.health.text.format = '[healthcolor][perhp<%]'
	E.db.nameplates.units.ENEMY_NPC.health.text.parent = 'Health'
	E.db.nameplates.units.ENEMY_NPC.health.text.yOffset = 1
	E.db.nameplates.units.ENEMY_NPC.level.enable = false
	E.db.nameplates.units.ENEMY_NPC.name.font = 'Expressway'
	E.db.nameplates.units.ENEMY_NPC.name.fontSize = 12
	E.db.nameplates.units.ENEMY_NPC.name.format = '[difficultycolor][level][shortclassification] [reactioncolor][name:medium]'
	E.db.nameplates.units.ENEMY_NPC.name.parent = 'Health'
	E.db.nameplates.units.ENEMY_NPC.name.xOffset = -1
	E.db.nameplates.units.ENEMY_NPC.name.yOffset = 4
	E.db.nameplates.units.ENEMY_NPC.power.width = 128
	E.db.nameplates.units.ENEMY_NPC.power.yOffset = -12

	--* Friendly NPC
	E.db.nameplates.units.FRIENDLY_NPC.buffs.xOffset = -1
	E.db.nameplates.units.FRIENDLY_NPC.buffs.yOffset = 10
	E.db.nameplates.units.FRIENDLY_NPC.castbar.font = 'Expressway'
	E.db.nameplates.units.FRIENDLY_NPC.castbar.iconOffsetY = -1
	E.db.nameplates.units.FRIENDLY_NPC.health.height = 20
	E.db.nameplates.units.FRIENDLY_NPC.health.text.font = 'Expressway'
	E.db.nameplates.units.FRIENDLY_NPC.health.text.format = '[healthcolor][perhp<%]'
	E.db.nameplates.units.FRIENDLY_NPC.health.text.parent = 'Health'
	E.db.nameplates.units.FRIENDLY_NPC.health.text.yOffset = 1
	E.db.nameplates.units.FRIENDLY_NPC.level.enable = false
	E.db.nameplates.units.FRIENDLY_NPC.name.font = 'Expressway'
	E.db.nameplates.units.FRIENDLY_NPC.name.fontSize = 12
	E.db.nameplates.units.FRIENDLY_NPC.name.format = '[difficultycolor][level][shortclassification] [reactioncolor][name:medium]'
	E.db.nameplates.units.FRIENDLY_NPC.name.parent = 'Health'
	E.db.nameplates.units.FRIENDLY_NPC.name.xOffset = -1
	E.db.nameplates.units.FRIENDLY_NPC.name.yOffset = 4
	E.db.nameplates.units.FRIENDLY_NPC.nameOnly = false

	--* Enemy Player
	E.db.nameplates.units.ENEMY_PLAYER.buffs.xOffset = -1
	E.db.nameplates.units.ENEMY_PLAYER.buffs.yOffset = 10
	E.db.nameplates.units.ENEMY_PLAYER.castbar.font = 'Expressway'
	E.db.nameplates.units.ENEMY_PLAYER.castbar.height = 5
	E.db.nameplates.units.ENEMY_PLAYER.castbar.iconOffsetY = -1
	E.db.nameplates.units.ENEMY_PLAYER.health.height = 12
	E.db.nameplates.units.ENEMY_PLAYER.health.text.font = 'Expressway'
	E.db.nameplates.units.ENEMY_PLAYER.health.text.format = '[healthcolor][perhp<%]'
	E.db.nameplates.units.ENEMY_PLAYER.health.text.parent = 'Health'
	E.db.nameplates.units.ENEMY_PLAYER.name.font = 'Expressway'
	E.db.nameplates.units.ENEMY_PLAYER.name.fontSize = 12
	E.db.nameplates.units.ENEMY_PLAYER.name.format = '[difficultycolor][level][shortclassification] [reactioncolor][name:abbrev:long]'
	E.db.nameplates.units.ENEMY_PLAYER.name.parent = 'Health'
	E.db.nameplates.units.ENEMY_PLAYER.name.xOffset = -1
	E.db.nameplates.units.ENEMY_PLAYER.name.yOffset = 4
	E.db.nameplates.units.ENEMY_PLAYER.portrait.enable = true
	E.db.nameplates.units.ENEMY_PLAYER.portrait.height = 34
	E.db.nameplates.units.ENEMY_PLAYER.portrait.position = 'LEFT'
	E.db.nameplates.units.ENEMY_PLAYER.portrait.width = 34
	E.db.nameplates.units.ENEMY_PLAYER.portrait.xOffset = -3
	E.db.nameplates.units.ENEMY_PLAYER.portrait.yOffset = 0
	E.db.nameplates.units.ENEMY_PLAYER.power.enable = true
	E.db.nameplates.units.ENEMY_PLAYER.power.height = 5
	E.db.nameplates.units.ENEMY_PLAYER.power.yOffset = -10

	--* Friendly Player
	E.db.nameplates.units.FRIENDLY_PLAYER.buffs.xOffset = -1
	E.db.nameplates.units.FRIENDLY_PLAYER.buffs.yOffset = 10
	E.db.nameplates.units.FRIENDLY_PLAYER.castbar.font = 'Expressway'
	E.db.nameplates.units.FRIENDLY_PLAYER.castbar.height = 5
	E.db.nameplates.units.FRIENDLY_PLAYER.castbar.iconOffsetY = -1
	E.db.nameplates.units.FRIENDLY_PLAYER.castbar.yOffset = -11
	E.db.nameplates.units.FRIENDLY_PLAYER.health.height = 12
	E.db.nameplates.units.FRIENDLY_PLAYER.health.text.font = 'Expressway'
	E.db.nameplates.units.FRIENDLY_PLAYER.health.text.format = '[healthcolor][perhp<%]'
	E.db.nameplates.units.FRIENDLY_PLAYER.health.text.parent = 'Health'
	E.db.nameplates.units.FRIENDLY_PLAYER.level.enable = false
	E.db.nameplates.units.FRIENDLY_PLAYER.name.font = 'Expressway'
	E.db.nameplates.units.FRIENDLY_PLAYER.name.fontSize = 12
	E.db.nameplates.units.FRIENDLY_PLAYER.name.format = '[difficultycolor][level][shortclassification] [classcolor][name]'
	E.db.nameplates.units.FRIENDLY_PLAYER.name.parent = 'Health'
	E.db.nameplates.units.FRIENDLY_PLAYER.name.xOffset = -1
	E.db.nameplates.units.FRIENDLY_PLAYER.name.yOffset = 4
	E.db.nameplates.units.FRIENDLY_PLAYER.portrait.enable = true
	E.db.nameplates.units.FRIENDLY_PLAYER.portrait.height = 34
	E.db.nameplates.units.FRIENDLY_PLAYER.portrait.position = 'LEFT'
	E.db.nameplates.units.FRIENDLY_PLAYER.portrait.width = 34
	E.db.nameplates.units.FRIENDLY_PLAYER.portrait.xOffset = -3
	E.db.nameplates.units.FRIENDLY_PLAYER.portrait.yOffset = 0
	E.db.nameplates.units.FRIENDLY_PLAYER.power.enable = true
	E.db.nameplates.units.FRIENDLY_PLAYER.power.height = 5
	E.db.nameplates.units.FRIENDLY_PLAYER.power.yOffset = -10

	E:ResetMovers()
	if not E.db.movers then E.db.movers = {} end

	--! Checked
	E.db.movers['AzeriteBarMover'] = 'RIGHT,MinimapMover,LEFT,2,0'
	E.db.movers['BuffsMover'] = 'TOPRIGHT,MinimapMover,TOPLEFT,-2,-1'
	E.db.movers['DebuffsMover'] = 'TOPRIGHT,BuffsMover,BOTTOMRIGHT,0,-1'
	E.db.movers['ElvAB_1'] = 'BOTTOM,ElvUIParent,BOTTOM,0,13'
	E.db.movers['ElvAB_2'] = 'RIGHT,ElvAB_1,LEFT,-40,0'
	E.db.movers['ElvAB_3'] = 'LEFT,ElvAB_1,RIGHT,40,0'
	E.db.movers['ElvAB_4'] = 'RIGHT,ElvUIParent,RIGHT,-4,0'
	E.db.movers['ElvAB_5'] = 'BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,556,13'
	E.db.movers['ElvAB_6'] = 'BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-556,13'
	E.db.movers['ElvUF_FocusMover'] = 'BOTTOMLEFT,ElvUF_PlayerMover,TOPLEFT,0,106'
	E.db.movers['ElvUF_FocusTargetMover'] = 'BOTTOMLEFT,ElvUF_FocusMover,TOPLEFT,0,68'
	E.db.movers['ElvUF_PartyMover'] = 'BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,448,226'
	E.db.movers['ElvUF_PetMover'] = 'BOTTOM,ElvUF_TargetTargetMover,TOP,0,50'
	E.db.movers['ElvUF_PlayerMover'] = 'BOTTOMLEFT,ElvAB_2,TOPLEFT,0,15'
	E.db.movers['ElvUF_Raid40Mover'] = 'BOTTOMLEFT,LeftChatMover,TOPLEFT,0,47'
	E.db.movers['ElvUF_RaidMover'] = 'BOTTOMLEFT,LeftChatMover,TOPLEFT,0,47'
	E.db.movers['ElvUF_TargetMover'] = 'BOTTOMRIGHT,ElvAB_3,TOPRIGHT,0,15'
	E.db.movers['ElvUF_TargetTargetMover'] = 'BOTTOM,ElvAB_1,TOP,0,15'
	E.db.movers['ElvUIBagMover'] = 'BOTTOMRIGHT,RightChatPanel,BOTTOMRIGHT,0,26'
	E.db.movers['ElvUIBankMover'] = 'BOTTOMLEFT,LeftChatPanel,BOTTOMLEFT,0,26'
	E.db.movers['ExperienceBarMover'] = 'TOP,TukuiCubeLeft,BOTTOM,0,-12'
	E.db.movers['HonorBarMover'] = 'TOP,TukuiCubeRight,BOTTOM,0,-12'
	E.db.movers['LeftChatMover'] = 'BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,35,20'
	E.db.movers['MinimapMover'] = 'TOPRIGHT,ElvUIParent,TOPRIGHT,-21,-21'
	E.db.movers['PetAB'] = 'RIGHT,ElvAB_4,LEFT,-1,0'
	E.db.movers['ReputationBarMover'] = 'LEFT,MinimapMover,RIGHT,-2,0'
	E.db.movers['RightChatMover'] = 'BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-35,20'
	E.db.movers['ThreatBarMover'] = 'BOTTOM,ElvUIParent,TOP,0,2'
	E.db.movers['TooltipMover'] = 'BOTTOMRIGHT,UIParent,BOTTOMRIGHT,-35,20'
	E.db.movers['ShiftAB'] = 'BOTTOMRIGHT,LeftChatMover,TOPRIGHT,0,3'

	--! Needs Checking
	-- E.db.movers['AlertFrameMover'] = 'TOP,ElvUIParent,TOP,0,-20'
	-- E.db.movers['AltPowerBarMover'] = 'TOP,ElvUIParent,TOP,0,-40'
	-- E.db.movers['ArenaHeaderMover'] = 'BOTTOMRIGHT,ElvUIParent,RIGHT,-105,-165'
	-- E.db.movers['BossButton'] = 'BOTTOM,ElvUIParent,BOTTOM,-150,300'
	-- E.db.movers['ElvUF_FocusCastbarMover'] = 'TOPLEFT,ElvUF_Focus,BOTTOMLEFT,0,-1'
	-- E.db.movers['ElvUF_PetCastbarMover'] = 'TOPLEFT,ElvUF_Pet,BOTTOMLEFT,0,-1'
	-- E.db.movers['ElvUF_TargetCastbarMover'] = 'BOTTOM,ElvUIParent,BOTTOM,-1,243'
	-- E.db.movers['ElvUF_PlayerCastbarMover'] = 'BOTTOMLEFT,UIParent,BOTTOMLEFT,728,379'

	E.db.movers['BNETMover'] = 'TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-274'
	E.db.movers['BelowMinimapContainerMover'] = 'TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-274'
	E.db.movers['BossBannerMover'] = 'TOP,ElvUIParent,TOP,0,-125'
	E.db.movers['BossHeaderMover'] = 'BOTTOMRIGHT,ElvUIParent,RIGHT,-105,-165'
	E.db.movers['DurabilityFrameMover'] = 'TOPLEFT,ElvUIParent,TOPLEFT,141,-4'
	E.db.movers['ElvUF_AssistMover'] = 'TOPLEFT,ElvUIParent,TOPLEFT,4,-248'
	E.db.movers['ElvUF_TankMover'] = 'TOPLEFT,ElvUIParent,TOPLEFT,4,-186'
	E.db.movers['EventToastMover'] = 'TOP,ElvUIParent,TOP,0,-150'
	E.db.movers['GMMover'] = 'TOPLEFT,ElvUIParent,TOPLEFT,250,-5'
	E.db.movers['LootFrameMover'] = 'TOPLEFT,ElvUIParent,TOPLEFT,418,-186'
	E.db.movers['LossControlMover'] = 'BOTTOM,ElvUIParent,BOTTOM,-1,507'
	E.db.movers['MawBuffsBelowMinimapMover'] = 'TOP,Minimap,BOTTOM,0,-25'
	E.db.movers['MicrobarMover'] = 'TOPLEFT,ElvUIParent,TOPLEFT,4,-48'
	E.db.movers['MirrorTimer1Mover'] = 'TOP,ElvUIParent,TOP,-1,-96'
	E.db.movers['MirrorTimer2Mover'] = 'TOP,MirrorTimer1,BOTTOM,0,0'
	E.db.movers['MirrorTimer3Mover'] = 'TOP,MirrorTimer2,BOTTOM,0,0'
	E.db.movers['ObjectiveFrameMover'] = 'TOPRIGHT,ElvUIParent,TOPRIGHT,-163,-325'
	E.db.movers['PetBattleABMover'] = 'BOTTOM,ElvUIParent,BOTTOM,0,4'
	E.db.movers['PetBattleStatusMover'] = 'TOP,PetBattleFrame,TOP,0,0'
	E.db.movers['PowerBarContainerMover'] = 'TOP,ElvUIParent,TOP,0,-75'
	E.db.movers['RaidMarkerBarAnchor'] = 'BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-1,200'
	E.db.movers['RaidUtility_Mover'] = 'TOP,ElvUIParent,TOP,-400,1'
	E.db.movers['TalkingHeadFrameMover'] = 'TOP,UIErrorsFrameMover,BOTTOM,0,50'
	E.db.movers['TopCenterContainerMover'] = 'TOP,ElvUIParent,TOP,0,-30'
	E.db.movers['TorghastChoiceToggle'] = 'CENTER,ElvUIParent,CENTER,0,-200'
	E.db.movers['TotemBarMover'] = 'BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,490,4'
	E.db.movers['UIErrorsFrameMover'] = 'TOP,UIParent,TOP,0,-122'
	E.db.movers['VOICECHAT'] = 'TOPLEFT,ElvUIParent,TOPLEFT,368,-210'
	E.db.movers['VehicleLeaveButton'] = 'BOTTOM,ElvUIParent,BOTTOM,0,300'
	E.db.movers['VehicleSeatMover'] = 'TOPLEFT,ElvUIParent,TOPLEFT,4,-4'
	E.db.movers['ZoneAbility'] = 'BOTTOM,ElvUIParent,BOTTOM,150,300'

	E:StaggeredUpdateAll()
	-- FUN:Print(L["Profile has been setup and loaded."])

	E:StaticPopup_Show('FUN_CONFIG_RL')
end

local function CreateTukuiPanels()
	if _G.TukuiBottomLine then return end

	local TukuiBottomLine = CreateFrame('Frame', 'TukuiBottomLine', E.UIParent)
	TukuiBottomLine:SetTemplate('Default')
	TukuiBottomLine:SetSize(2, 2)
	TukuiBottomLine:Point('BOTTOMLEFT', 18, 30)
	TukuiBottomLine:Point('BOTTOMRIGHT', -18, 30)
	TukuiBottomLine:SetFrameStrata('BACKGROUND')
	TukuiBottomLine:SetFrameLevel(0)
	-- TukuiBottomLine:CreateShadow(2)

	local TukuiLeftVerticalLine = CreateFrame('Frame', 'TukuiLeftVerticalLine', TukuiBottomLine)
	TukuiLeftVerticalLine:SetTemplate('Default')
	TukuiLeftVerticalLine:SetSize(2, E.db.chat.panelHeight or 180)
	TukuiLeftVerticalLine:Point('BOTTOMRIGHT', TukuiBottomLine, 'BOTTOMLEFT', 0, 0)
	TukuiLeftVerticalLine:SetFrameLevel(0)
	TukuiLeftVerticalLine:SetFrameStrata('BACKGROUND')
	TukuiLeftVerticalLine:SetAlpha(1)
	-- TukuiLeftVerticalLine:CreateShadow(2)

	local TukuiRightVerticalLine = CreateFrame('Frame', 'TukuiRightVerticalLine', TukuiBottomLine)
	TukuiRightVerticalLine:SetTemplate('Default')
	TukuiRightVerticalLine:SetSize(2, E.db.chat.separateSizes and E.db.chat.panelHeightRight or E.db.chat.panelHeight or 180)
	TukuiRightVerticalLine:Point('BOTTOMLEFT', TukuiBottomLine, 'BOTTOMRIGHT', 0, 0)
	TukuiRightVerticalLine:SetFrameLevel(0)
	TukuiRightVerticalLine:SetFrameStrata('BACKGROUND')
	TukuiRightVerticalLine:SetAlpha(1)
	-- TukuiRightVerticalLine:CreateShadow(2)

	local TukuiCubeLeft = CreateFrame('Frame', 'TukuiCubeLeft', TukuiLeftVerticalLine)
	TukuiCubeLeft:SetTemplate('Default')
	TukuiCubeLeft:SetSize(10, 10)
	TukuiCubeLeft:Point('BOTTOM', TukuiLeftVerticalLine, 'TOP', 0, E.PixelMode and 0 or E.Border)
	TukuiCubeLeft:EnableMouse(true)
	TukuiCubeLeft:SetFrameLevel(0)
	-- TukuiCubeLeft:CreateShadow(2)
	TukuiCubeLeft:SetScript('OnMouseDown', function(_, Button)
		if (Button == 'LeftButton') then
			ToggleFrame(_G['ChatMenu'])
		end
	end)

	local TukuiCubeRight = CreateFrame('Frame', 'TukuiCubeRight', TukuiRightVerticalLine)
	TukuiCubeRight:SetTemplate('Default')
	TukuiCubeRight:SetSize(10, 10)
	TukuiCubeRight:Point('BOTTOM', TukuiRightVerticalLine, 'TOP', 0, E.PixelMode and 0 or E.Border)
	TukuiCubeRight:EnableMouse(true)
	TukuiCubeRight:SetFrameLevel(0)
	-- TukuiCubeRight:CreateShadow(2)
	TukuiCubeRight:SetScript('OnMouseDown', function(_, button)
		if (button == 'LeftButton') then
			ToggleCharacter('ReputationFrame')
		end
	end)
end
CreateTukuiPanels()

function FUN:UpdateTukuiPanels()
	if not _G.TukuiBottomLine then CreateTukuiPanels() end
	_G.TukuiBottomLine:SetShown(E.db.fun.tukui.enable)
end

function FUN:InitializeTukui()
	if not E.db.fun.tukui.enable then return end
	FUN:Print("|cffFF8000Tukui|r: |cff00FF00Enabled|r")
	FUN:UpdateTukuiPanels()
end
