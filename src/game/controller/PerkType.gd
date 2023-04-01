enum PerkTypeEnum {
	APPLE,
	LEMON,
	CHERRY,
	ORANGE,
	CHILI,
	STAR,
	GAIN_COIN,
	LOSS_COIN,
	DIAMOND,
	BANANA,
	AVOCADO,
	CANDY,
	SNAIL
}

class_name PerkType
# intended to be used and Enum that can be exported easily

static func APPLE() -> int: return PerkTypeEnum.APPLE
static func LEMON() -> int: return PerkTypeEnum.LEMON
static func CHERRY() -> int: return PerkTypeEnum.CHERRY
static func ORANGE() -> int: return PerkTypeEnum.ORANGE
static func CHILI() -> int: return PerkTypeEnum.CHILI
static func STAR() -> int: return PerkTypeEnum.STAR
static func GAIN_COIN() -> int: return PerkTypeEnum.GAIN_COIN
static func LOSS_COIN() -> int: return PerkTypeEnum.LOSS_COIN
static func DIAMOND() -> int: return PerkTypeEnum.DIAMOND
static func BANANA() -> int: return PerkTypeEnum.BANANA
static func AVOCADO() -> int: return PerkTypeEnum.AVOCADO
static func CANDY() -> int: return PerkTypeEnum.CANDY
static func SNAIL() -> int: return PerkTypeEnum.SNAIL

static func get_perk_type_string(type: int) -> String:
	match type:
		PerkTypeEnum.APPLE: return "Apple"
		PerkTypeEnum.LEMON: return "Lemon"
		PerkTypeEnum.CHERRY: return "Cherry"
		PerkTypeEnum.ORANGE: return "Orange"
		PerkTypeEnum.CHILI: return "Chili"
		PerkTypeEnum.STAR: return "Star"
		PerkTypeEnum.GAIN_COIN: return "GainCoin"
		PerkTypeEnum.LOSS_COIN: return "LossCoin"
		PerkTypeEnum.DIAMOND: return "Diamond"
		PerkTypeEnum.BANANA: return "Banana"
		PerkTypeEnum.AVOCADO: return "Avocado"
		PerkTypeEnum.CANDY: return "Candy"
		PerkTypeEnum.SNAIL: return "Snail"
	return "ERROR"

static func get_perk_type_int(type: String) -> int:
	if(type == "Apple"): return PerkTypeEnum.APPLE
	elif(type == "Lemon"): return PerkTypeEnum.LEMON
	elif(type == "Cherry"): return PerkTypeEnum.CHERRY
	elif(type == "Orange"): return PerkTypeEnum.ORANGE
	elif(type == "Chili"): return PerkTypeEnum.CHILI
	elif(type == "Star"): return PerkTypeEnum.STAR
	elif(type == "GainCoin"): return PerkTypeEnum.GAIN_COIN
	elif(type == "LossCoin"): return PerkTypeEnum.LOSS_COIN
	elif(type == "Diamond"): return PerkTypeEnum.DIAMOND
	elif(type == "Banana"): return PerkTypeEnum.BANANA
	elif(type == "Avocado"): return PerkTypeEnum.AVOCADO
	elif(type == "Candy"): return PerkTypeEnum.CANDY
	elif(type == "Snail"): return PerkTypeEnum.SNAIL
	return -1
