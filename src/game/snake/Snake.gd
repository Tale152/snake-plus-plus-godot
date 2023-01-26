extends Node2D

const BodyPart = preload("./BodyPart.tscn")

var _properties: Properties
var _body_parts: Array
var _game
var _px: int
	
func initialize(game):
	_game = game
	_px = _game.get_visual_parameters().get_cell_pixels_size()
	_properties = Properties.new(
		_game.get_stage_description().get_snake_initial_direction()
	)
	_body_parts = []
	$Head.initialize(_game)

func get_properties() -> Properties:
	return _properties
	
func move(movement_delta: float):
	_shorten_body_if_necessary()
	var previous_part_old_placement: Placement = _move_body()
	_lenghten_body_if_necessary(previous_part_old_placement)
	_render_snake(movement_delta)

func get_head_coordinates() -> ImmutablePoint:
	return ImmutablePoint.new(
		$Head.get_placement().get_coordinates().get_x(),
		$Head.get_placement().get_coordinates().get_y()
	)

func get_body_coordinates() -> Array:
	var res = []
	for b in _body_parts:
		res.push_back(ImmutablePoint.new(
			b.get_placement().get_coordinates().get_x(),
			b.get_placement().get_coordinates().get_y()
		))
	return res

func get_body_part(index: int):
	return _body_parts[index]
	
func _shorten_body_if_necessary() -> void:
	var to_remove = _properties.get_potential_length() - _properties.get_current_length()
	if to_remove < 0:
		_properties.set_current_length(_properties.get_potential_length())
		to_remove *= -1
		for i in to_remove:
			var removed = _body_parts.pop_back()
			if removed != null:
				removed.queue_free()
		if _properties.get_current_length() > 1:
			_body_parts[-1].get_placement().set_previous_direction(-1)
		else:
			$Head.get_placement().set_previous_direction(-1)
		
func _move_body() -> Placement:
	# storing previous head placement
	var previous_part_old_placement = Placement.new(
			$Head.get_placement().get_coordinates(),
			$Head.get_placement().get_next_direction(),
			$Head.get_placement().get_previous_direction()
		)
	
	# setting new placement values for head
	var x: int = $Head.get_placement().get_coordinates().get_x()
	var y: int = $Head.get_placement().get_coordinates().get_y()
	var next_direction: int
	if _properties.get_current_direction() == Directions.get_right():
		x += 1
		next_direction = Directions.get_right()
	elif _properties.get_current_direction() == Directions.get_left():
		x -= 1
		next_direction = Directions.get_left()
	elif _properties.get_current_direction() == Directions.get_up():
		y -= 1
		next_direction = Directions.get_up()
	elif _properties.get_current_direction() == Directions.get_down():
		y += 1
		next_direction = Directions.get_down()
	var field_size: FieldSize = _game.get_stage_description().get_field_size()
	if x < 0:
		x = field_size.get_width() -1
	elif x >= field_size.get_width():
		x = 0
	if y < 0:
		y = field_size.get_height() - 1
	elif y >= field_size.get_height():
		y = 0
	$Head.set_placement(Placement.new(
		ImmutablePoint.new(x, y),
		next_direction,
		$Head.get_placement().get_previous_direction()
	))
	
	# moving body
	if _body_parts.size() > 0:
		# adjusting head to have the correct previous_direction
		$Head.get_placement().set_previous_direction(
			Directions.get_opposite(next_direction)
		)
		# adjusting previous_part_old_placement to have the correct next_direction
		previous_part_old_placement.set_next_direction(
			$Head.get_placement().get_next_direction()
		)
		# shifting the placement in the body
		for b in _body_parts:
			var tmp: Placement = b.get_placement()
			b.set_placement(previous_part_old_placement)
			previous_part_old_placement = tmp
		# adjusting tail to have the correct previous_direction
		var tail = _body_parts[-1]
		tail.get_placement().set_previous_direction(-1)
	return previous_part_old_placement

func _lenghten_body_if_necessary(previous_part_old_placement: Placement) -> void:
	if _properties.get_potential_length() > _properties.get_current_length():
		_properties.set_current_length(_properties.get_current_length() + 1)
		#correcting previous tail sprite
		var target = $Head if _properties.get_current_length() == 2 else _body_parts[-1]
		target.get_placement().set_previous_direction(
				Directions.get_opposite(
					previous_part_old_placement.get_next_direction()
				)
			)
		# creating new body part
		var new_body_part = BodyPart.instance()
		new_body_part.spawn(
			previous_part_old_placement,
			self,
			_game
		)
		add_child(new_body_part)
		_body_parts.push_back(new_body_part)
		
func _render_snake(movement_delta: float):
	$Head.move_to_placement()
	for b in _body_parts:
		b.move_to_placement()
	var speed_scale = 1 / movement_delta
	$Head.play_sprite_animation(speed_scale)
	for b in _body_parts:
		b.play_sprite_animation(speed_scale)
