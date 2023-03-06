class_name PauseMenu extends Control

var _invoker

func set_invoker(invoker) -> void:
	_invoker = invoker

func _on_ContinueButton_pressed():
	self.visible = false
	_invoker.change_pause_status()

func _on_RestartButton_pressed():
	_invoker.restart()

func _on_BackToMenuButton_pressed():
	_invoker.show_menu()
