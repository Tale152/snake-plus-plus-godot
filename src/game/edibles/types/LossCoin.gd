class_name LossCoin extends Reference

const LOSS_COIN_POINTS = 2000

func execute(
	_placement,
	_rules,
	_snake,
	_game	
) -> bool:
	var player: Player = _game.get_player()
	var updated_points = player.get_points() - LOSS_COIN_POINTS * player.get_multiplier()
	player.set_points(updated_points if updated_points > 0 else 0)
	return true
