class_name StageDescriptionBuilder extends Reference

var _size: FieldSize

func set_field_size(size: FieldSize) -> StageDescriptionBuilder:
	_size = size
	return self

func build() -> StageDescription:
	if _is_field_size_valid():
		return StageDescription.new(_size)
	return null
	
func _is_field_size_valid():
	return _size != null && _size.get_height() > 0 && _size.get_width() > 0
