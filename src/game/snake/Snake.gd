class_name Snake extends Node2D

var _properties: SnakeProperties
var _body_parts: Array
var _game
var _px: int
var _head: SnakeHead
var _effects: Array
	
func _init(game):
	_game = game
	_px = _game.get_visual_parameters().get_cell_pixels_size()
	_properties = SnakeProperties.new(
		_game.get_stage_description().get_snake_initial_direction()
	)
	_body_parts = []
	_effects = []
	_head = SnakeHead.new(_game)
	self.add_child(_head)

func get_properties() -> SnakeProperties:
	return _properties

func get_head() -> SnakeHead:
	return _head

func get_body_parts() -> Array:
	return _body_parts

func play_sprites_animation(movement_delta: float) -> void:
	var speed_scale: float = 1 / movement_delta
	_head.play_sprite_animation(speed_scale)
	for b in _body_parts:
		b.play_sprite_animation(speed_scale)

func stop_sprites_animation() -> void:
	_head.stop_sprite_animation()
	for b in _body_parts:
		b.stop_sprite_animation()

func move(movement_delta: float) -> void:
	_shorten_body_if_necessary()
	var previous_part_old_placement: SnakeUnitPlacement = _move_snake()
	_lenghten_body_if_necessary(previous_part_old_placement)
	_render_snake(movement_delta)

func add_effect(effect: EquippedEffect) -> void:
	var i = _get_effect_index(effect.get_type())
	if i != -1: _effects[i] = effect
	else:
		_effects.push_back(effect)
		effect.apply_effect()

func has_effect(type: String) -> bool:
	return _get_effect_index(type) != -1

func get_effects_timers() -> Array:
	var res = []
	for e in _effects:
		res.push_back(e.get_timer())
	return res

func tick_effects(delta: float) -> void:
	var i = 0
	while(i < _effects.size()):
		var e = _effects[i]
		if e.tick(delta):
			e.revoke_effect()
			_effects.erase(e)
		else:
			i += 1

func _get_effect_index(type: String) -> int:
	var i = 0
	for e in _effects:
		if e.get_type() == type: return i
		i += 1
	return -1

func _shorten_body_if_necessary() -> void:
	var n_body_parts_to_remove = _properties.get_potential_length() - _properties.get_current_length()
	if n_body_parts_to_remove < 0:
		_properties.set_current_length(_properties.get_potential_length())
		for _i in range(0, n_body_parts_to_remove * -1):
			_body_parts.pop_back().queue_free()
		if _properties.get_current_length() > 1:
			_body_parts[-1].get_placement().set_previous_direction(-1)
		else:
			_head.get_placement().set_previous_direction(-1)
		
func _move_snake() -> SnakeUnitPlacement:
	var previous_part_old_placement = _clone_head_placement()
	_head.set_placement(_calculate_head_new_placement())
	return _move_body(previous_part_old_placement)

func _clone_head_placement() -> SnakeUnitPlacement:
	return SnakeUnitPlacement.new(
		_head.get_placement().get_coordinates(),
		_head.get_placement().get_next_direction(),
		_head.get_placement().get_previous_direction()
	)

func _calculate_head_new_placement() -> SnakeUnitPlacement:
	var field_size: FieldSize = _game.get_stage_description().get_field_size()
	var head_coordinates = _head.get_placement().get_coordinates()
	# intentionally written like this to be as computationally efficient as possible
	if _properties.get_current_direction() == Directions.get_right():
		var x = head_coordinates.get_x() + 1
		return SnakeUnitPlacement.new(
			ImmutablePoint.new(
				x if x < field_size.get_width() else 0,
				head_coordinates.get_y()
			),
			Directions.get_right(),
			_head.get_placement().get_previous_direction()
		)
	elif _properties.get_current_direction() == Directions.get_left():
		var x = head_coordinates.get_x() - 1
		return SnakeUnitPlacement.new(
			ImmutablePoint.new(
				x if x >= 0 else field_size.get_width() - 1,
				head_coordinates.get_y()
			),
			Directions.get_left(),
			_head.get_placement().get_previous_direction()
		)
	elif _properties.get_current_direction() == Directions.get_up():
		var y = head_coordinates.get_y() - 1
		return SnakeUnitPlacement.new(
			ImmutablePoint.new(
				head_coordinates.get_x(),
				y if y >= 0 else field_size.get_height() - 1
			),
			Directions.get_up(),
			_head.get_placement().get_previous_direction()
		)
	else:
		var y = head_coordinates.get_y() + 1
		return SnakeUnitPlacement.new(
			ImmutablePoint.new(
				head_coordinates.get_x(),
				y if y < field_size.get_height() else 0
			),
			Directions.get_down(),
			_head.get_placement().get_previous_direction()
		)

func _move_body(
	previous_part_old_placement: SnakeUnitPlacement
) -> SnakeUnitPlacement:
	if _body_parts.size() > 0:
		var head_next_direction = _head.get_placement().get_next_direction()
		# adjusting head to have the correct previous_direction
		_head.get_placement().set_previous_direction(
			Directions.get_opposite(head_next_direction)
		)
		# adjusting previous_part_old_placement to have the correct next_direction
		previous_part_old_placement.set_next_direction(head_next_direction)
		# shifting the placement in the body
		for b in _body_parts:
			var tmp: SnakeUnitPlacement = b.get_placement()
			b.set_placement(previous_part_old_placement)
			previous_part_old_placement = tmp
		# adjusting tail to have the correct previous_direction
		var tail = _body_parts[-1]
		tail.get_placement().set_previous_direction(-1)
	return previous_part_old_placement

func _lenghten_body_if_necessary(
	previous_part_old_placement: SnakeUnitPlacement
) -> void:
	if _properties.get_potential_length() > _properties.get_current_length():
		_properties.set_current_length(_properties.get_current_length() + 1)
		#correcting previous tail sprite
		var target = _head if _properties.get_current_length() == 2 else _body_parts[-1]
		target.get_placement().set_previous_direction(
			Directions.get_opposite(
				previous_part_old_placement.get_next_direction()
			)
		)
		# creating new body part
		var new_body_part = SnakeBodyPart.new(
			previous_part_old_placement,
			self,
			_game
		)
		add_child(new_body_part)
		_body_parts.push_back(new_body_part)
		
func _render_snake(movement_delta: float) -> void:
	# do not use play_sprite_animation, better to replicate code than to slow down very frequent code execution
	var speed_scale: float = 1 / movement_delta
	_head.update_position_on_screen()
	_head.update_sprite()
	_head.play_sprite_animation(speed_scale)
	for b in _body_parts:
		b.update_position_on_screen()
		b.update_sprite()
		b.play_sprite_animation(speed_scale)
