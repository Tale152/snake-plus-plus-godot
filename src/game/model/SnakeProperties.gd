class_name SnakeProperties extends Reference

var _current_direction: int
var _alive: bool = true
var _current_length: int = 1
var _potential_length: int = 1
var _speed_multiplier: float = 1.0
var _score: int = 0
var _score_multiplier: float = 1.0
var _invincible: bool = false
var _intangible: bool = false

func _init(initial_direction: int):
	_current_direction = initial_direction

func get_current_direction() -> int: return _current_direction

func set_current_direction(direction: int) -> void:
	_current_direction = direction

func is_alive() -> bool: return _alive

func set_is_alive(flag: bool) -> void: _alive = flag

func get_current_length() -> int: return _current_length

func set_current_length(length: int) -> void: _current_length = length

func get_potential_length() -> int: return _potential_length

func set_potential_length(length: int) -> void: _potential_length = length

func get_speed_multiplier() -> float: return _speed_multiplier

func set_speed_multiplier(multiplier: float) -> void:
	_speed_multiplier = multiplier

func get_score() -> int: return _score

func set_score(score: int) -> void: _score = score

func get_score_multiplier() -> float: return _score_multiplier

func set_score_multiplier(multiplier: float) -> void: _score_multiplier = multiplier

func is_invincible() -> bool: return _invincible

func set_invincible(flag: bool) -> void: _invincible = flag

func is_intangible() -> bool: return _intangible

func set_intangible(flag: bool) -> void: _intangible = flag
