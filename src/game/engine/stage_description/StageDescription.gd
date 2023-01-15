class_name StageDescription extends Reference

var _size: FieldSize

func _init(size: FieldSize):
	_size = size

func get_field_size() -> FieldSize:
	return _size

# TODO add more fields
