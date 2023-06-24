class_name ArcadeStageInfo extends Control

var _data: ArcadeStageData
var _on_play_pressed: FuncRef
var _on_back_pressed: FuncRef

func initialize(
	data: ArcadeStageData,
	on_play_pressed: FuncRef,
	on_back_pressed: FuncRef
) -> void:
	_data = data
	_on_play_pressed = on_play_pressed
	_on_back_pressed = on_back_pressed

func _on_PlayButton_pressed():
	_on_play_pressed.call_func(_data)

func _on_BackButton_pressed():
	_on_back_pressed.call_func()
