class_name VisualParametersBuilder extends Reference

const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")

var _cell_pixels_size: int
var _edible_sprites: Array = []
var _snake_skin_path: String

func set_cell_pixels_size(size: int) -> VisualParametersBuilder:
	_cell_pixels_size = size
	return self

func set_snake_skin_path(path: String) -> VisualParametersBuilder:
	_snake_skin_path = path
	return self

func add_edible_sprite(sprite: EdibleSprite) -> VisualParametersBuilder:
	_edible_sprites.push_back(sprite)
	return self

func build() -> VisualParameters:
	var head_sprites = []
	var tail_sprites = []
	var body_sprites = []
	for d in DirectionsEnum.get_directions():
		head_sprites.push_back(SnakeHeadSprite.new(_snake_skin_path, d, true))
		head_sprites.push_back(SnakeHeadSprite.new(_snake_skin_path, d, false))
		tail_sprites.push_back(SnakeTailSprite.new(_snake_skin_path, d))
		for j in DirectionsEnum.get_directions():
			if DirectionsEnum.are_diagonal(d,j):
				body_sprites.push_back(SnakeBodySprite.new(_snake_skin_path, d, j))
	return VisualParameters.new(
		_cell_pixels_size,
		_edible_sprites,
		head_sprites,
		body_sprites,
		tail_sprites
	)
