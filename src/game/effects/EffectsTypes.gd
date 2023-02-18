class_name EffectTypes

static func get_types() -> Array:
	return [
		ORANGE(),
		SNAIL(),
		CHILI(),
	]

static func ORANGE() -> String:
	return EdibleTypes.ORANGE()

static func SNAIL() -> String:
	return EdibleTypes.SNAIL()

static func CHILI() -> String:
	return EdibleTypes.CHILI()
