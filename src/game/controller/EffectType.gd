class_name EffectType
# intended to be used and Enum that can be exported easily

static func ORANGE() -> int: return PerkType.ORANGE()
static func CHILI() -> int: return PerkType.CHILI()
static func STAR() -> int: return PerkType.STAR()
static func BANANA() -> int: return PerkType.BANANA()
static func AVOCADO() -> int: return PerkType.AVOCADO()
static func SNAIL() -> int: return PerkType.SNAIL()
static func GHOST() -> int: return PerkType.GHOST()
static func BEER() -> int: return PerkType.BEER()

static func get_effects() -> Array:
	return [
		PerkType.ORANGE(),
		PerkType.CHILI(),
		PerkType.STAR(),
		PerkType.BANANA(),
		PerkType.AVOCADO(),
		PerkType.SNAIL(),
		PerkType.GHOST(),
		PerkType.BEER()
	]
