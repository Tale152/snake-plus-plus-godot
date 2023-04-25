class_name SwipeControls extends Control

var _up_arrow_strategy: FuncRef
var _right_arrow_strategy: FuncRef
var _down_arrow_strategy: FuncRef
var _left_arrow_strategy: FuncRef
var _pause_button_strategy: FuncRef
var _restart_button_strategy: FuncRef

var _swipe_positive_treshhold: int
var _swipe_negative_treshold: int
var _swipe_relative_accumulator: Vector2 = Vector2(0, 0)

func scale(scale: float) -> void:
	_swipe_positive_treshhold = (ProjectSettings.get("display/window/size/width") / 8.5) * scale
	_swipe_negative_treshold = _swipe_positive_treshhold * - 1

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

func set_restart_button_strategy(strategy: FuncRef) -> void:
	_restart_button_strategy = strategy

func _on_PauseButton_button_down():
	_pause_button_strategy.call_func()

func _on_RestartButton_button_down():
	_restart_button_strategy.call_func()

func _input(event: InputEvent):
	if event is InputEventScreenDrag:
		_swipe_relative_accumulator += event.relative
		if _swipe_relative_accumulator.x >= _swipe_positive_treshhold:
			_swipe_relative_accumulator.x = 0
			_swipe_relative_accumulator.y = 0
			_right_arrow_strategy.call_func()
		elif _swipe_relative_accumulator.y >= _swipe_positive_treshhold:
			_swipe_relative_accumulator.x = 0
			_swipe_relative_accumulator.y = 0
			_down_arrow_strategy.call_func()
		elif _swipe_relative_accumulator.x <= _swipe_negative_treshold:
			_swipe_relative_accumulator.x = 0
			_swipe_relative_accumulator.y = 0
			_left_arrow_strategy.call_func()
		elif _swipe_relative_accumulator.y <= _swipe_negative_treshold:
			_swipe_relative_accumulator.x = 0
			_swipe_relative_accumulator.y = 0
			_up_arrow_strategy.call_func()
	elif event is InputEventScreenTouch and event.is_pressed():
		_swipe_relative_accumulator.x = 0
		_swipe_relative_accumulator.y = 0
