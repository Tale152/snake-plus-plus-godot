class_name BadApple extends Reference

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	if _snake.get_properties().get_potential_length() > 1:
		_snake.get_properties().set_potential_length(
			_snake.get_properties().get_potential_length() - 1
		)
	return true
