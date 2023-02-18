class_name EdibleTypes

static func get_types() -> Array:
	return [
		APPLE(),
		BAD_APPLE(),
		CHERRY(),
		GAIN_COIN(),
		LOSS_COIN(),
		ORANGE()
	]

static func APPLE() -> String:
	return "Apple"

static func BAD_APPLE() -> String:
	return "BadApple"

static func CHERRY() -> String:
	return "Cherry"

static func GAIN_COIN() -> String:
	return "GainCoin"

static func LOSS_COIN() -> String:
	return "LossCoin"

static func ORANGE() -> String:
	return "Orange"
