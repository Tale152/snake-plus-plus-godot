class_name GameModel extends Reference

var _field: Field
var _equipped_effects_container: EquippedEffectsContainer
var _snake_properties: SnakeProperties

func _init(
	width: int,
	height: int,
	snake_head: SnakeBodyPart,
	perk_types: Array,
	walls: Array,
	initial_direction: int
):
	_equipped_effects_container = EquippedEffectsContainer.new()
	_field = Field.new(
		width,
		height,
		snake_head,
		perk_types,
		walls
	)
	_snake_properties = SnakeProperties.new(initial_direction)

func get_field() -> Field:
	return _field

func get_equipped_effects_container() -> EquippedEffectsContainer:
	return _equipped_effects_container

func get_snake_properties() -> SnakeProperties:
	return _snake_properties
