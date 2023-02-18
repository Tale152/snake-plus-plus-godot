class_name EffectTypes

static func get_types() -> Array:
	return [
		ORANGE(),
		SNAIL(),
		CHILI(),
		STAR(),
	]

static func ORANGE() -> String:
	return EdibleTypes.ORANGE()

static func SNAIL() -> String:
	return EdibleTypes.SNAIL()

static func CHILI() -> String:
	return EdibleTypes.CHILI()

static func STAR() -> String:
	return EdibleTypes.STAR()
