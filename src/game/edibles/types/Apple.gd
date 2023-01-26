class_name Apple extends Reference

func execute(
	_placement,
	_rules,
	_snake,
	_game	
) -> bool:
	_snake.get_properties().set_potential_length(
		_snake.get_properties().get_potential_length() + 1
	)
	return true
