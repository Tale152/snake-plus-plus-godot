class_name VisualParametersBuilder extends Reference

var _cell_pixels_size: int
var _edible_sprites: Array = []

func set_cell_pixels_size(size: int) -> VisualParametersBuilder:
	_cell_pixels_size = size
	return self

func add_edible_sprite(sprite: EdibleSprite) -> VisualParametersBuilder:
	_edible_sprites.push_back(sprite)
	return self

func build() -> VisualParameters:
	return VisualParameters.new(
		_cell_pixels_size,
		_edible_sprites
	)
