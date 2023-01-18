class_name VisualParameters extends Reference

var _cell_pixels_size: int
var _sprites

func _init(cell_pixels_size: int, sprites):
	_cell_pixels_size = cell_pixels_size
	_sprites = sprites

func get_cell_pixels_size() -> int:
	return _cell_pixels_size

func get_sprite(name: String):
	for s in _sprites:
		if s[0] == name:
			return s[1]
