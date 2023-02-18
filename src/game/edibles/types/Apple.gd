class_name Apple extends Reference

const APPLE_POINTS = 200

func execute(
	_placement,
	_rules,
	_snake,
	_game	
) -> bool:
	_snake.get_properties().set_potential_length(
		_snake.get_properties().get_potential_length() + 1
	)
	var player: Player = _game.get_player()
	player.set_points(
		player.get_points() + APPLE_POINTS * player.get_multiplier()
	)
	return true
