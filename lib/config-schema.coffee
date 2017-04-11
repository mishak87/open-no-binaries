module.exports =
	excludeFileTypes:
		type: "object"
		properties:
			enabled:
				order: 1
				title: "Enabled"
				type: "boolean"
				default: true
			excluded:
				order: 2
				title: "Don't check these file types:"
				description: "Use comma separated, lowercase values (e.g. `pdf, ico, png`)"
				type: "array"
				default: [ "png", "jpeg", "jpg", "gif", "ico", "bmp", "webp" ]
