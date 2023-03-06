class_name GameOverMenu extends Control

var _invoker

func set_invoker(invoker) -> void:
	_invoker = invoker

func _on_PlayAgainButton_pressed():
	_invoker.restart()

func _on_BackToMenuButton_pressed():
	_invoker.show_menu()
