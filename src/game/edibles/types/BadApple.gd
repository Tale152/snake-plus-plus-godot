class_name BadApple extends Reference

func execute(placement, rules, snake, game):
	if snake.get_properties().get_potential_length() > 1:
		snake.get_properties().set_potential_length(
			snake.get_properties().get_potential_length() - 1
		)
	return true
