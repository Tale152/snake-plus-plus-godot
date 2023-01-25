extends Area2D

signal snake_head_collision(collidable)

var placement
var s
var e
var _visual_parameters
var _sprite

func spawn(starting_placement, snake, engine, visual_parameters):
	self.connect("snake_head_collision", snake, "on_collision")
	s = snake
	e = engine
	_visual_parameters = visual_parameters
	move_to(starting_placement)

func move_to(new_placement):
	placement = new_placement
	var px = _visual_parameters.get_cell_pixels_size()
	position = Vector2(placement.coordinates.x, placement.coordinates.y)
	var sprite_tmp
	if(placement.previous_direction == null):
		sprite_tmp = _visual_parameters \
		.get_tail_sprite(placement.next_direction)
	else:
		sprite_tmp = _visual_parameters \
		.get_body_sprite(placement.next_direction, placement.previous_direction)
	sprite_tmp.set_offset(Vector2(px / 2, px / 2))
	if _sprite != null:
		remove_child(_sprite)
	_sprite = sprite_tmp
	self.add_child(_sprite)

func _on_BodyPart_area_entered(area):
	if area == s.get_node("Head"):
		emit_signal("snake_head_collision", self)

func on_snake_head_collision():
	e.set_game_over(true)

func play_sprite_animation(speed_scale):
	_sprite.speed_scale = speed_scale
	_sprite.play()
