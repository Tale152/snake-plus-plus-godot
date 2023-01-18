class_name EdibleTypes

static func get_types() -> Array:
	return [
		APPLE(),
		BAD_APPLE()
	]

static func APPLE() -> String:
	return "Apple"

static func BAD_APPLE() -> String:
	return "BadApple"
