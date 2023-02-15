class_name Wall extends Area2D

var _wall_sprite: AnimatedSprite
var _coordinates: ImmutablePoint
var _connections: CardinalConnections

func _init(
	coordinates: ImmutablePoint,
	stage_description: StageDescription,
	visual_parameters: VisualParameters
):
	_coordinates = coordinates
	position = PositionCalculator.calculate_position(
		coordinates,
		visual_parameters.get_cell_pixels_size(),
		visual_parameters.get_game_pixels_offset()
	)
	_connections = _generate_connections(coordinates, stage_description)
	_wall_sprite = visual_parameters.get_wall_sprite(_connections)
	add_child(_wall_sprite)

func get_coordinates() -> ImmutablePoint:
	return _coordinates

func get_connections() -> CardinalConnections:
	return _connections

func play_sprite_animation(speed_scale: float) -> void:
	_wall_sprite.speed_scale = speed_scale
	_wall_sprite.play()

func stop_sprite_animation() -> void:
	_wall_sprite.stop()

func _generate_connections(
	coordinates: ImmutablePoint,
	stage_desciption: StageDescription
) -> CardinalConnections:
	var directions = []
	if _check_direction(coordinates, stage_desciption, Directions.get_up()):
		directions.push_back(Directions.get_up())
	if _check_direction(coordinates, stage_desciption, Directions.get_right()):
		directions.push_back(Directions.get_right())
	if _check_direction(coordinates, stage_desciption, Directions.get_down()):
		directions.push_back(Directions.get_down())
	if _check_direction(coordinates, stage_desciption, Directions.get_left()):
		directions.push_back(Directions.get_left())
	return CardinalConnections.new(directions)

func _check_direction(
	coordinates: ImmutablePoint,
	stage_description: StageDescription,
	direction: int
) -> bool:
	var dX = 0
	var dY = 0
	if direction == Directions.get_up(): dY = -1
	elif direction == Directions.get_right(): dX = 1
	elif direction == Directions.get_down(): dY = 1
	else: dX = -1
	var direction_coordinates: ImmutablePoint = ImmutablePoint.new(
		coordinates.get_x() + dX,
		coordinates.get_y() + dY
	)
	return (
		_is_inside_field(direction_coordinates, stage_description) &&
		_wall_point_exists(direction_coordinates, stage_description)
	)

func _is_inside_field(
	point: ImmutablePoint,
	stage_description: StageDescription
) -> bool:
	return (
		point.get_x() >= 0 && 
		point.get_x() < stage_description.get_field_size().get_width() &&
		point.get_y() >= 0 &&
		point.get_y() < stage_description.get_field_size().get_height()
	)

func _wall_point_exists(
	point: ImmutablePoint,
	stage_description: StageDescription
) -> bool:
	for wp in stage_description.get_walls_points():
		if wp.equals_to(point): return true
	return false
