local _, _, V, P, _ = unpack(ElvUI)

P.fun = {
	hellokitty = {
		enable = false,
	},
	tukui = {
		enable = false,
	},
	lines = {
		top = {
			enable = false,
			horizontal = {
				width = 2,
				yOffset = -30,
				borderColor = {r = 0, g = 1, b = .59},
				backdropColor = {r = 0, g = 1, b = .59},
			},
			left = {
				length = 180,
				width = 2,
				xOffset = 18,
				borderColor = {r = 0, g = 1, b = .59},
				backdropColor = {r = 0, g = 1, b = .59},
				cube = {
					borderColor = {r = 0, g = 1, b = .59},
					backdropColor = {r = 0, g = 1, b = .59},
				},
			},
			right = {
				length = 180,
				width = 2,
				xOffset = -18,
				borderColor = {r = 0, g = 1, b = .59},
				backdropColor = {r = 0, g = 1, b = .59},
				cube = {
					borderColor = {r = 0, g = 1, b = .59},
					backdropColor = {r = 0, g = 1, b = .59},
				},
			},
		},
		bottom = {
			enable = false,
			horizontal = {
				width = 2,
				yOffset = 30,
				borderColor = {r = 0, g = 1, b = .59},
				backdropColor = {r = 0, g = 1, b = .59},
			},
			left = {
				length = 180,
				width = 2,
				xOffset = 18,
				borderColor = {r = 0, g = 1, b = .59},
				backdropColor = {r = 0, g = 1, b = .59},
				cube = {
					borderColor = {r = 0, g = 1, b = .59},
					backdropColor = {r = 0, g = 1, b = .59},
				},
			},
			right = {
				length = 180,
				width = 2,
				xOffset = -18,
				borderColor = {r = 0, g = 1, b = .59},
				backdropColor = {r = 0, g = 1, b = .59},
				cube = {
					borderColor = {r = 0, g = 1, b = .59},
					backdropColor = {r = 0, g = 1, b = .59},
				},
			},
		},
	},
}

V.fun = {} --* Specifically here to E.private.fun.install_complate check in Core.lua doesn't error.
