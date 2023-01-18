class_name BadApple extends Reference

func execute(placement, rules, snake, game):
	if snake.properties.potential_length > 1:
		snake.properties.potential_length -= 1
	return true
