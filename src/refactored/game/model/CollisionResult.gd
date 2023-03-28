class_name CollisionResult extends Reference

var _to_be_removed: bool

func _init(to_be_removed: bool):
	_to_be_removed = to_be_removed

func has_to_be_removed() -> bool:
	return _to_be_removed
