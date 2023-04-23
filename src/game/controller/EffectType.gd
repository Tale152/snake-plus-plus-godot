class_name EffectType
# intended to be used and Enum that can be exported easily

static func ORANGE() -> int: return PerkType.ORANGE()
static func CHILI() -> int: return PerkType.CHILI()
static func STAR() -> int: return PerkType.STAR()
static func BANANA() -> int: return PerkType.BANANA()
static func AVOCADO() -> int: return PerkType.AVOCADO()
static func SNAIL() -> int: return PerkType.SNAIL()

static func get_effects() -> Array:
	return [
		ORANGE(),
		CHILI(),
		STAR(),
		BANANA(),
		AVOCADO(),
		SNAIL()
	]
