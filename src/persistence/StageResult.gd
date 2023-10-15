class_name StageResult extends Reference

var _time: float
var _score: int
var _length: int

func _init(time: float, score: int, length: int):
	_time = time
	_score = score
	_length = length

func get_time() -> float:
	return _time

func get_score() -> int:
	return _score

func get_length() -> int:
	return _length

func equals_to(compared: StageResult) -> bool:
	return (
		_time == compared.get_time() &&
		_score == compared.get_score() &&
		_length == compared.get_length()
	)
