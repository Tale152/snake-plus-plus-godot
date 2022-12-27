extends Node2D

const DirectionsEnum = preload("res://src/enums/DirectionsEnum.gd")
const BodyPart = preload("./BodyPart.tscn")
const Properties = preload("./Properties.gd").Properties
const Placement = preload("./Placement.gd").Placement

var properties
var body_parts
var field_s
	
func initialize(direction, coordinates, field_size):
	properties = Properties.new(direction)
	field_s = field_size
	body_parts = []
	var tmp = Placement.new(coordinates, direction, null)
	$Head.initialize(tmp)

func on_collision(collidable):
	collidable.on_snake_head_collision(self)
	
func move(sprite_size):
	var previous_part_old_placement = _move_body(sprite_size)
	_lenghten_body_if_necessary(previous_part_old_placement)
	_render_snake()
	
func _move_body(sprite_size):
	# storing previous head placement
	var previous_part_old_placement = Placement.new(
		$Head.placement.coordinates,
		$Head.placement.next_direction,
		$Head.placement.previous_direction
	)
	
	# moving head
	match properties.current_direction:
		DirectionsEnum.DIRECTIONS.RIGHT:
			$Head.placement.coordinates.x += sprite_size
			$Head.placement.next_direction = DirectionsEnum.DIRECTIONS.RIGHT
		DirectionsEnum.DIRECTIONS.LEFT:
			$Head.placement.coordinates.x -= sprite_size
			$Head.placement.next_direction = DirectionsEnum.DIRECTIONS.LEFT
		DirectionsEnum.DIRECTIONS.UP:
			$Head.placement.coordinates.y -= sprite_size
			$Head.placement.next_direction = DirectionsEnum.DIRECTIONS.UP
		DirectionsEnum.DIRECTIONS.DOWN:
			$Head.placement.coordinates.y += sprite_size
			$Head.placement.next_direction = DirectionsEnum.DIRECTIONS.DOWN
	if $Head.placement.coordinates.x < 0:
		$Head.placement.coordinates.x = field_s.x - sprite_size
	elif $Head.placement.coordinates.x >= field_s.x:
		$Head.placement.coordinates.x = 0
	elif $Head.placement.coordinates.y < 0:
		$Head.placement.coordinates.y = field_s.y - sprite_size
	elif $Head.placement.coordinates.y >= field_s.y:
		$Head.placement.coordinates.y = 0
	
	# moving body
	if body_parts.size() > 0:
		# adjusting head to have the correct previous_direction
		$Head.placement.previous_direction = DirectionsEnum.get_opposite($Head.placement.next_direction)
		# adjusting previous_part_old_placement to have the correct next_direction
		previous_part_old_placement.next_direction = $Head.placement.next_direction
		# shifting the placement in the body
		for b in body_parts:
			var tmp = b.placement
			b.placement = previous_part_old_placement
			previous_part_old_placement = tmp
		# adjusting tail to have the correct previous_direction
		var tail = body_parts[-1]
		tail.placement.previous_direction = null
	return previous_part_old_placement

func _lenghten_body_if_necessary(previous_part_old_placement):
	if properties.potential_length > properties.current_length:
		properties.current_length += 1
		#correcting previous tail sprite
		if properties.current_length == 2:
			$Head.placement.previous_direction = DirectionsEnum.get_opposite(previous_part_old_placement.next_direction)
			$Head.move_to($Head.placement)
		else:
			var previous_tail = body_parts[-1]
			previous_tail.placement.previous_direction = DirectionsEnum.get_opposite(previous_part_old_placement.next_direction)
			previous_tail.move_to(previous_tail.placement)
		# creating new body part
		var new_body_part = BodyPart.instance()
		new_body_part.spawn(previous_part_old_placement)
		add_child(new_body_part)
		body_parts.push_back(new_body_part)
		
func _render_snake():
	$Head.move_to($Head.placement)
	for b in body_parts:
		b.move_to(b.placement)
