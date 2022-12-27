extends Area2D

signal collision(collidable)

func spawn(spawn_position, snake):
	position = spawn_position
	self.connect("collision", snake, "on_collision")

func _on_Apple_area_entered(area):
	emit_signal("collision", self)
	self.queue_free()
	
func on_snake_head_collision(snake):
	snake.increase_length(1)
