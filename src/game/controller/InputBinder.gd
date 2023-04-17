class_name InputBinder extends Reference

static func bind(
	controller,
	view,
	exit_game_strategy: FuncRef
) -> void:
	var resume_game_strategy: FuncRef = funcref(controller, "_resume_game")
	var start_new_game_strategy: FuncRef = funcref(controller, "start_new_game")
	var controls = view.get_controls()
	controls.set_up_arrow_strategy(funcref(controller, "_up_direction_input"))
	controls.set_right_arrow_strategy(funcref(controller, "_right_direction_input"))
	controls.set_down_arrow_strategy(funcref(controller, "_down_direction_input"))
	controls.set_left_arrow_strategy(funcref(controller, "_left_direction_input"))
	controls.set_pause_button_strategy(funcref(controller, "_enter_pause"))
	controls.set_restart_button_strategy(funcref(controller, "_enter_restart"))
	var pause = view.get_pause_menu()
	pause.set_on_continue_button_pressed_strategy(resume_game_strategy)
	pause.set_on_restart_button_pressed_strategy(start_new_game_strategy)
	pause.set_on_back_to_menu_button_pressed_strategy(exit_game_strategy)
	var restart = view.get_restart_menu()
	restart.set_on_yes_button_pressed_strategy(start_new_game_strategy)
	restart.set_on_no_button_pressed_strategy(resume_game_strategy)
