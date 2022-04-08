local E, L, _, P = unpack(ElvUI)
local FUN = E:GetModule('ElvUI_FunStuff')
local _G = _G
local CreateFrame = CreateFrame
-- local GetCVar, SetCVar = GetCVar, SetCVar

local function OnDragStart(frame)
	frame:StartMoving()
end

local function OnDragStop(frame)
	frame:StopMovingOrSizing()
end

local function OnUpdate(frame, elapsed)
	if frame.elapsed and frame.elapsed > 0.1 then
		frame.tex:SetTexCoord((frame.curFrame - 1) * 0.1, 0, (frame.curFrame - 1) * 0.1, 1, frame.curFrame * 0.1, 0, frame.curFrame * 0.1, 1)

		if frame.countUp then
			frame.curFrame = frame.curFrame + 1
		else
			frame.curFrame = frame.curFrame - 1
		end

		if frame.curFrame > 10 then
			frame.countUp = false
			frame.curFrame = 9
		elseif frame.curFrame < 1 then
			frame.countUp = true
			frame.curFrame = 2
		end
		frame.elapsed = 0
	else
		frame.elapsed = (frame.elapsed or 0) + elapsed
	end
end

function FUN:ToggleHelloKittySound()

end

function FUN:SetupHelloKitty(newProfile)
	if newProfile then
		E.data:SetProfile('Hello Kitty v'..FUN.Version)
		E.db.convertPages = true
		E.private.general.pixelPerfect = true
		E.db.fun.tukui.enable = false

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

		--* Unitframe (General)
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
		E.db.unitframe.units.player.name.text_format = '[difficultycolor][level] [classcolor][name:medium]  [shortclassification]'
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
	end
	E.db.fun.hellokitty.enable = true

	E.db.general.backdropfadecolor = {r =131/255, g =36/255, b = 130/255, a = 0.36}
	E.db.general.backdropcolor = {r = 223/255, g = 76/255, b = 188/255}
	E.db.general.bordercolor = {r = 223/255, g = 217/255, b = 47/255}
	E.db.general.valuecolor = {r = 223/255, g = 217/255, b = 47/255}

	E.db.chat.panelBackdropNameLeft = E.Media.Textures.HelloKittyChat
	E.db.chat.panelBackdropNameRight = E.Media.Textures.HelloKittyChat

	E.db.unitframe.colors = E:CopyTable({}, P.unitframe.colors)
	E.db.unitframe.colors.castColor = {r = 223/255, g = 76/255, b = 188/255}
	E.db.unitframe.colors.transparentCastbar = true
	E.db.unitframe.colors.auraBarBuff = {r = 223/255, g = 76/255, b = 188/255}
	E.db.unitframe.colors.transparentAurabars = true
	E.db.unitframe.colors.health = {r = 223/255, g = 76/255, b = 188/255}
	E.db.unitframe.colors.healthclass = false

	-- SetCVar('Sound_EnableAllSound', 1)
	-- SetCVar('Sound_EnableMusic', 1)
	-- PlayMusic(E.Media.Sounds.HelloKitty)
	-- E:StaticPopup_Show('HELLO_KITTY_END')

	E:StaggeredUpdateAll()
	FUN:Print(L["Profile has been setup and loaded."])
end

function FUN:CreateKittys()
	if _G.HelloKittyLeft then
		return
	end
	local helloKittyLeft = CreateFrame('Frame', 'HelloKittyLeft', _G.UIParent)
	helloKittyLeft:Size(120, 128)
	helloKittyLeft:SetMovable(true)
	helloKittyLeft:EnableMouse(true)
	helloKittyLeft:RegisterForDrag('LeftButton')
	helloKittyLeft:Point('BOTTOMLEFT', _G.LeftChatPanel, 'BOTTOMRIGHT', 2, -24)
	helloKittyLeft.tex = helloKittyLeft:CreateTexture(nil, 'OVERLAY')
	helloKittyLeft.tex:SetAllPoints()
	helloKittyLeft.tex:SetTexture(E.Media.Textures.HelloKitty)
	helloKittyLeft.tex:SetTexCoord(0, 0, 0, 1, 0, 0, 0, 1)
	helloKittyLeft.curFrame = 1
	helloKittyLeft.countUp = true
	helloKittyLeft:SetClampedToScreen(true)
	helloKittyLeft:SetScript('OnDragStart', OnDragStart)
	helloKittyLeft:SetScript('OnDragStop', OnDragStop)
	helloKittyLeft:SetScript('OnUpdate', OnUpdate)

	local helloKittyRight = CreateFrame('Frame', 'HelloKittyRight', _G.UIParent)
	helloKittyRight:Size(120, 128)
	helloKittyRight:SetMovable(true)
	helloKittyRight:EnableMouse(true)
	helloKittyRight:RegisterForDrag('LeftButton')
	helloKittyRight:Point('BOTTOMRIGHT', _G.RightChatPanel, 'BOTTOMLEFT', -2, -24)
	helloKittyRight.tex = helloKittyRight:CreateTexture(nil, 'OVERLAY')
	helloKittyRight.tex:SetAllPoints()
	helloKittyRight.tex:SetTexture(E.Media.Textures.HelloKitty)
	helloKittyRight.tex:SetTexCoord(0, 0, 0, 1, 0, 0, 0, 1)
	helloKittyRight.curFrame = 10
	helloKittyRight.countUp = false
	helloKittyRight:SetClampedToScreen(true)
	helloKittyRight:SetScript('OnDragStart', OnDragStart)
	helloKittyRight:SetScript('OnDragStop', OnDragStop)
	helloKittyRight:SetScript('OnUpdate', OnUpdate)
end

-- function FUN:ToggleDancingKittys()
function FUN:UpdateDancingKittys()
	if not _G.HelloKittyLeft or not _G.HelloKittyRight then FUN:CreateKittys() end
	_G.HelloKittyLeft:SetShown(E.db.fun.hellokitty.enable)
	_G.HelloKittyRight:SetShown(E.db.fun.hellokitty.enable)
end

function FUN:InitializeHelloKitty()
	if not E.db.fun.hellokitty.enable then return end
	FUN:Print("|cffDF4CBCHello Kitty|r: |cff00FF00Enabled|r")
	FUN:CreateKittys()
end
