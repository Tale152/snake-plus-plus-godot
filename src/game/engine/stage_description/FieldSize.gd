class FieldSize extends Reference:
	var _height: int
	var _width: int

	func _init(height: int, width: int):
		_height = height
		_width = width

	func get_height() -> int:
		return _height

	func get_width() -> int:
		return _width
