local _, _, V, P, _ = unpack(ElvUI)

local sharedValues = {
	enable = false,
	horizontal = {
		width = 2,
		-- yOffset = -30,
		borderColor = {r = 0, g = 0, b = 0, a = 1},
		backdropColor = {r = 0, g = 0, b = 0, a = 1},
	},
	left = {
		length = 180,
		width = 2,
		xOffset = 18,
		borderColor = {r = 0, g = 0, b = 0, a = 1},
		backdropColor = {r = 0, g = 0, b = 0, a = 1},
		cube = {
			borderColor = {r = 0, g = 0, b = 0, a = 1},
			backdropColor = {r = 0.36, g = 0.36, b = 0.36, a = 1},
		},
	},
	right = {
		length = 180,
		width = 2,
		xOffset = -18,
		borderColor = {r = 0, g = 0, b = 0, a = 1},
		backdropColor = {r = 0, g = 0, b = 0, a = 1},
		cube = {
			borderColor = {r = 0, g = 0, b = 0, a = 1},
			backdropColor = {r = 0.36, g = 0.36, b = 0.36, a = 1},
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
P.fun.lines.bottom.horizontal.yOffset = -30
V.fun = {} --* Specifically here to E.private.fun.install_complate check in Core.lua doesn't error.
