class_name GameOverData extends Reference

var _is_highscore: bool
var _stars: int
var _added_coins: int

func _init(is_highscore: bool, stars: int, added_coins: int):
	_is_highscore = is_highscore
	_stars = stars
	_added_coins = added_coins

func is_highscore() -> bool:
	return _is_highscore

func get_stars() -> int:
	return _stars

func get_added_coins() -> int:
	return _added_coins
