class_name VisualParametersBuilder extends Reference

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
	for d in Directions.get_directions():
		head_sprites.push_back(SnakeHeadSprite.new(_snake_skin_path, d, true))
		head_sprites.push_back(SnakeHeadSprite.new(_snake_skin_path, d, false))
		tail_sprites.push_back(SnakeTailSprite.new(_snake_skin_path, d))
		for j in Directions.get_directions():
			if d != j:
				body_sprites.push_back(SnakeBodySprite.new(_snake_skin_path, d, j))
	_scale_array_of_sprites(head_sprites, _cell_pixels_size)
	_scale_array_of_sprites(body_sprites, _cell_pixels_size)
	_scale_array_of_sprites(tail_sprites, _cell_pixels_size)
	_scale_array_of_sprites(_edible_sprites, _cell_pixels_size)
	return VisualParameters.new(
		_cell_pixels_size,
		_edible_sprites,
		head_sprites,
		body_sprites,
		tail_sprites
	)

func _scale_array_of_sprites(arr, cell_pixels_size) -> void:
	var px: float = float(cell_pixels_size)
	for elem in arr:
		var sprite = elem.get_sprite()
		var width = float(sprite.get_sprite_frames().get_frame("default",0).get_width())
		var scale = px / width
		sprite.set_scale(Vector2(scale, scale))
		var offset = (px / 2) / scale
		sprite.set_offset(Vector2(offset, offset))
