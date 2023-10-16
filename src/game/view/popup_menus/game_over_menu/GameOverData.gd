class_name GameOverData extends Reference

var _is_highscore: bool
var _stars: int

func _init(is_highscore: bool, stars: int):
	_is_highscore = is_highscore
	_stars = stars

func is_highscore() -> bool:
	return _is_highscore

func get_stars() -> int:
	return _stars
