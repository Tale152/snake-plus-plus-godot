class_name ExpireTimer extends Reference

var _elapsed_seconds: float
var _lifespan_seconds: float

func _init(lifespan_seconds: float = -1.0):
	_lifespan_seconds = lifespan_seconds
	_elapsed_seconds = -1.0 if _lifespan_seconds == -1.0 else 0.0

func tick(delta_seconds: float) -> void:
	if _lifespan_seconds != -1.0:
		_elapsed_seconds += delta_seconds

func can_expire() -> bool:
	return _lifespan_seconds != -1.0

func has_expired() -> bool:
	if _lifespan_seconds == -1.0:
		# keep performances in mind, do not use can_expire
		return false
	return _elapsed_seconds >= _lifespan_seconds

func get_lifespan_percentage() -> float:
	if _lifespan_seconds == -1.0:
		# keep performances in mind, do not use can_expire
		return -1.0
	var percentage: float = _elapsed_seconds / _lifespan_seconds
	return 1.0 if percentage > 1.0 else percentage
