extends PersistentDictionaryNode

const _COINS: String = "coins"

const FIRST_STAR_COINS_REGULAR: int = 100
const SECOND_STAR_COINS_REGULAR: int = 200
const THIRD_STAR_COINS_REGULAR: int = 300
const FIRST_STAR_COINS_PRO: int = 200
const SECOND_STAR_COINS_PRO: int = 300
const THIRD_STAR_COINS_PRO: int = 400

const ARCADE_SCORE_TRESHOLD_REGULAR: int = 25000
const ARCADE_SCORE_TRESHOLD_PRO: int = 20000
const ARCADE_LENGTH_TRESHOLD_REGULAR: int = 30
const ARCADE_LENGTH_TRESHOLD_PRO: int = 25

const _FILE_PATH: String = "user://wallet.json"
const _DEFAULT: Dictionary = {
	_COINS: 0
}

func _ready():
	_initialize(_DEFAULT, _FILE_PATH)

func get_coins() -> int:
	return _get_data(_COINS)

func set_coins(coins: int) -> void:
	_set_data(_COINS, coins)

func add_coins(to_add: int) -> void:
	set_coins(get_coins() + to_add)

func subtract_coins(to_subtract: int) -> bool:
	var current_coins: int = get_coins()
	if (current_coins - to_subtract) >= 0:
		set_coins(current_coins - to_subtract)
		return true
	return false

func add_arcade_coins(score: int, length: int) -> int:
	var to_add: int = int(
		(score / _get_arcade_score_treshold()) +
		(length / _get_arcade_length_treshold())
	)
	if to_add > 0:
		add_coins(to_add)
	return to_add

func _get_arcade_score_treshold() -> int:
	if PersistentPlaySettings.is_regular_difficulty():
		return ARCADE_SCORE_TRESHOLD_REGULAR
	else:
		return ARCADE_SCORE_TRESHOLD_PRO

func _get_arcade_length_treshold() -> int:
	if PersistentPlaySettings.is_regular_difficulty():
		return ARCADE_LENGTH_TRESHOLD_REGULAR
	else:
		return ARCADE_LENGTH_TRESHOLD_REGULAR

func add_challenge_coins(unlocked_stars: Array) -> int:
	var to_add: int = 0
	if PersistentPlaySettings.is_regular_difficulty():
		if 1 in unlocked_stars:
			to_add += FIRST_STAR_COINS_REGULAR
		if 2 in unlocked_stars:
			to_add += SECOND_STAR_COINS_REGULAR
		if 3 in unlocked_stars:
			to_add += THIRD_STAR_COINS_REGULAR
	else:
		if 1 in unlocked_stars:
			to_add += FIRST_STAR_COINS_PRO
		if 2 in unlocked_stars:
			to_add += SECOND_STAR_COINS_PRO
		if 3 in unlocked_stars:
			to_add += THIRD_STAR_COINS_PRO
	if to_add > 0:
		add_coins(to_add)
	return to_add
