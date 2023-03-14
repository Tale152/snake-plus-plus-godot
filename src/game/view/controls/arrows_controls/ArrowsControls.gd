class_name ArrowsControls extends Control

var _up_arrow_strategy: FuncRef
var _right_arrow_strategy: FuncRef
var _down_arrow_strategy: FuncRef
var _left_arrow_strategy: FuncRef
var _pause_button_strategy: FuncRef
var _restart_button_strategy: FuncRef

func _ready():
	self.anchor_top = 0
	self.anchor_right = 1
	self.anchor_bottom = 1
	self.anchor_left = 0

func set_up_arrow_strategy(strategy: FuncRef) -> void:
	_up_arrow_strategy = strategy

func set_right_arrow_strategy(strategy: FuncRef) -> void:
	_right_arrow_strategy = strategy

func set_down_arrow_strategy(strategy: FuncRef) -> void:
	_down_arrow_strategy = strategy

func set_left_arrow_strategy(strategy: FuncRef) -> void:
	_left_arrow_strategy = strategy

func set_pause_button_strategy(strategy: FuncRef) -> void:
	_pause_button_strategy = strategy

func restart_button_strategy(strategy: FuncRef) -> void:
	_restart_button_strategy = strategy

func _on_RestartButton_button_down():
	_restart_button_strategy.call_func()

func _on_PauseButton_button_down():
	_pause_button_strategy.call_func()

func _on_UpButton_button_down():
	_up_arrow_strategy.call_func()

func _on_RightButton_button_down():
	_right_arrow_strategy.call_func()

func _on_DownButton_button_down():
	_down_arrow_strategy.call_func()

func _on_LeftButton_button_down():
	_left_arrow_strategy.call_func()
