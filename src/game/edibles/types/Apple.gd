class_name Apple extends Reference

func execute(placement, rules, snake, game):
	snake.get_properties().set_potential_length(
		snake.get_properties().get_potential_length() + 1
	)
	return true
