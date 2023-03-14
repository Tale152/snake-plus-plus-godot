class_name RestartMenu extends Control

var _invoker

func set_invoker(invoker) -> void:
	_invoker = invoker

func _on_YesButton_pressed():
	_invoker.restart()

func _on_NoButton_pressed():
	self.visible = false
	_invoker.change_pause_status()
