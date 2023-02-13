class_name VisualParametersBuilder extends Reference

var _cell_pixels_size: int
var _game_pixels_offset: Vector2
var _edible_sprites: Array = []
var _snake_skin_path: String
var _field_elements_skin_path: String

func set_cell_pixels_size(size: int) -> VisualParametersBuilder:
	_cell_pixels_size = size
	return self

func set_game_pixels_offset(offset: Vector2) -> VisualParametersBuilder:
	_game_pixels_offset = offset
	return self

func set_snake_skin_path(path: String) -> VisualParametersBuilder:
	_snake_skin_path = path
	return self

func set_field_elements_skin_path(path: String) -> VisualParametersBuilder:
	_field_elements_skin_path = path
	return self

func add_edible_sprite(sprite: EdibleSprite) -> VisualParametersBuilder:
	_edible_sprites.push_back(sprite)
	return self

func build() -> VisualParameters:
	var head_sprites = []
	var body_sprites = []
	var tail_sprites = []
	var background_sprites = []
	var walls_sprites = []
	_populate_snake_sprites(
		head_sprites,
		body_sprites,
		tail_sprites
	)
	_populate_background_sprites(background_sprites)
	_populate_walls_sprites(walls_sprites)
	_scale_array_of_sprites(head_sprites, _cell_pixels_size)
	_scale_array_of_sprites(body_sprites, _cell_pixels_size)
	_scale_array_of_sprites(tail_sprites, _cell_pixels_size)
	_scale_array_of_sprites(_edible_sprites, _cell_pixels_size)
	_scale_array_of_sprites(background_sprites, _cell_pixels_size)
	_scale_array_of_sprites(walls_sprites, _cell_pixels_size)
	return VisualParameters.new(
		_cell_pixels_size,
		_game_pixels_offset,
		_edible_sprites,
		head_sprites,
		body_sprites,
		tail_sprites,
		background_sprites,
		walls_sprites
	)

func _populate_snake_sprites(head_sprites, body_sprites, tail_sprites) -> void:
	for d in Directions.get_directions():
		head_sprites.push_back(SnakeHeadSprite.new(_snake_skin_path, d, true))
		head_sprites.push_back(SnakeHeadSprite.new(_snake_skin_path, d, false))
		tail_sprites.push_back(SnakeTailSprite.new(_snake_skin_path, d))
		for j in Directions.get_directions():
			if d != j:
				body_sprites.push_back(SnakeBodySprite.new(_snake_skin_path, d, j))

func _populate_walls_sprites(walls_sprites: Array) -> void:
	for u in 2: for r in 2: for d in 2: for l in 2:
		var connections = []
		if u == 1: connections.push_back(Directions.get_up())
		if r == 1: connections.push_back(Directions.get_right())
		if d == 1: connections.push_back(Directions.get_down())
		if l == 1: connections.push_back(Directions.get_left())
		walls_sprites.push_back(WallSprite.new(
			_field_elements_skin_path,
			CardinalConnections.new(connections)
		))

func _populate_background_sprites(background_sprites) -> void:
	var i = 0
	var file = AssetFiles.build_asset_path(
		_field_elements_skin_path,
		"ground_" + str(i),
		0
	)
	while AssetFiles.asset_exists(file):
		background_sprites.push_back(
			FieldSprite.new(
				_field_elements_skin_path,
				"ground_" + str(i)
				)
			)
		i += 1
		file = AssetFiles.build_asset_path(
			_field_elements_skin_path,
			"ground_" + str(i),
			0
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
