class_name EdibleTypes

static func get_types() -> Array:
	return [
		APPLE(),
		BAD_APPLE(),
		CHERRY(),
		GAIN_COIN(),
		LOSS_COIN(),
		ORANGE(),
		SNAIL(),
		CHILI(),
		STAR(),
		DIAMOND(),
		BANANA(),
		AVOCADO(),
		CANDY(),
		SLOT_MACHINE(),
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

static func SNAIL() -> String:
	return "Snail"

static func CHILI() -> String:
	return "Chili"

static func STAR() -> String:
	return "Star"

static func DIAMOND() -> String:
	return "Diamond"

static func BANANA() -> String:
	return "Banana"

static func AVOCADO() -> String:
	return "Avocado"

static func CANDY() -> String:
	return "Candy"

static func SLOT_MACHINE() -> String:
	return "SlotMachine"
