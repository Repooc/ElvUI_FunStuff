local _, _, V, P, _ = unpack(ElvUI)

local sharedValues = {
	enable = false,
	customGlow = {
		style = 'Autocast Shine',
		color = { r = 1, g = 0.486, b = 0.039, a = 1 },
	},
	horizontal = {
		width = 2,
		borderColor = {r = 0, g = 0, b = 0, a = 1},
		backdropColor = {r = 0, g = 0, b = 0, a = 1},
		useCustomGlow = false,
		customGlow = {
			useStyle = false,
			style = 'Autocast Shine',
			color = { r = 0.15, g = 0.647, b = 1, a = 1 },
			startAnimation = true,
			useColor = false,
			duration = 1,
			speed = 0.04,
			lines = 20,
			size = 1,
		},
	},
	left = {
		length = 180,
		width = 2,
		xOffset = 18,
		borderColor = {r = 0, g = 0, b = 0, a = 1},
		backdropColor = {r = 0, g = 0, b = 0, a = 1},
		useCustomGlow = false,
		customGlow = {
			useStyle = false,
			style = 'Autocast Shine',
			color = { r = 1, g = 0.486, b = 0.039, a = 1 },
			startAnimation = true,
			useColor = false,
			duration = 1,
			speed = 0.2,
			lines = 2,
			size = 1,
		},
		cube = {
			width = 10,
			height = 10,
			size = 6,
			borderColor = {r = 0, g = 0, b = 0, a = 1},
			backdropColor = {r = 0.36, g = 0.36, b = 0.36, a = 1},
			useCustomGlow = false,
			customGlow = {
				useStyle = false,
				style = 'Autocast Shine',
				color = { r = 1, g = 0.486, b = 0.039, a = 1 },
				startAnimation = true,
				useColor = false,
				duration = 1,
				speed = 0.3,
				lines = 8,
				size = 1,
			},
		},
	},
	right = {
		length = 180,
		width = 2,
		xOffset = -18,
		borderColor = {r = 0, g = 0, b = 0, a = 1},
		backdropColor = {r = 0, g = 0, b = 0, a = 1},
		useCustomGlow = false,
		customGlow = {
			useStyle = false,
			style = 'Autocast Shine',
			color = { r = 1, g = 0.486, b = 0.039, a = 1 },
			startAnimation = true,
			useColor = false,
			duration = 1,
			speed = 0.2,
			lines = 2,
			size = 1,
		},
		cube = {
			width = 10,
			height = 10,
			size = 10,
			borderColor = {r = 0, g = 0, b = 0, a = 1},
			backdropColor = {r = 0.36, g = 0.36, b = 0.36, a = 1},
			useCustomGlow = false,
			customGlow = {
				useStyle = false,
				style = 'Autocast Shine',
				color = { r = 1, g = 0.486, b = 0.039, a = 1 },
				startAnimation = true,
				useColor = false,
				duration = 1,
				speed = 0.3,
				lines = 8,
				size = 1,
			},
		},
	},
}

P.fun = {
	hellokitty = {
		enable = false,
	},
	tukui = {
		enable = false,
	},
	lines = {
		top = CopyTable(sharedValues),
		bottom = CopyTable(sharedValues),
	},
}
P.fun.lines.top.horizontal.yOffset = -30
P.fun.lines.bottom.horizontal.yOffset = 30
V.fun = {} --* Specifically here to E.private.fun.install_complate check in Core.lua doesn't error.
