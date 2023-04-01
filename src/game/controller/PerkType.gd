enum PerkTypeEnum {
	APPLE,
	LEMON,
	CHERRY,
	ORANGE
}
#TODO extend

class_name PerkType
# intended to be used and Enum that can be exported easily

static func APPLE() -> int: return PerkTypeEnum.APPLE
static func LEMON() -> int: return PerkTypeEnum.LEMON
static func CHERRY() -> int: return PerkTypeEnum.CHERRY
static func ORANGE() -> int: return PerkTypeEnum.ORANGE
#TODO extend

static func get_perk_type_string(type: int) -> String:
	match type:
		PerkTypeEnum.APPLE: return "Apple"
		PerkTypeEnum.LEMON: return "Lemon"
		PerkTypeEnum.CHERRY: return "Cherry"
		PerkTypeEnum.ORANGE: return "Orange"
	return "ERROR"
