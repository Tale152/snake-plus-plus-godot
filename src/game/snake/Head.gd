extends Area2D

var placement
var _visual_parameters
var _sprite

func initialize(starting_placement, visual_parameters):
	_visual_parameters = visual_parameters
	move_to(starting_placement)
	
func move_to(new_placement):
	placement = new_placement
	position = placement.coordinates
	_set_sprite()

func _set_sprite():
	var sprite_tmp = _visual_parameters \
		.get_head_sprite(
			placement.next_direction,
			placement.previous_direction == null # is tail?
		)
	var px = _visual_parameters.get_cell_pixels_size()
	sprite_tmp.set_offset(Vector2(px / 2, px / 2))
	if _sprite != null:
		remove_child(_sprite)
	_sprite = sprite_tmp
	self.add_child(_sprite)

func play_sprite_animation(speed_scale):
	_sprite.speed_scale = speed_scale
	_sprite.play()
