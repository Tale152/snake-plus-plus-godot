class_name BadApple extends Reference

func execute(
	_placement,
	_rules,
	_snake,
	_game
) -> bool:
	var potential_length = _snake.get_properties().get_potential_length()
	var new_lenght = round(_snake.get_properties().get_potential_length() / 2)
	_snake.get_properties().set_potential_length(
		new_lenght if potential_length > 1 else 1
	)
	var player: Player = _game.get_player()
	player.set_points(
		round(player.get_points() / 2)
	)
	return true
