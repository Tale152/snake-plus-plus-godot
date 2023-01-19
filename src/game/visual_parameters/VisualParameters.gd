class_name VisualParameters extends Reference

var _cell_pixels_size: int
var _edible_sprites: Array

func _init(
	cell_pixels_size: int,
	edible_sprites: Array
):
	_cell_pixels_size = cell_pixels_size
	_edible_sprites = edible_sprites

func get_cell_pixels_size() -> int:
	return _cell_pixels_size

func get_edible_sprite(name: String) -> EdibleSprite:
	for s in _edible_sprites:
		if s.get_name() == name:
			return s.get_sprite()
	return null
