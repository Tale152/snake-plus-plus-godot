extends Area2D

signal snake_head_collision(collidable)

var e
var s

func get_type():
	return "Apple"
	
func spawn(spawn_position, snake, engine):
	s = snake
	e = engine
	position = spawn_position
	self.connect("snake_head_collision", snake, "on_collision")

func _on_Apple_area_entered(area):
	if area == s.get_node("Head"):
		emit_signal("snake_head_collision", self)
		self.hide()
		e.remove_edible(self)
	
	
func on_snake_head_collision():
	s.properties.potential_length += 1
