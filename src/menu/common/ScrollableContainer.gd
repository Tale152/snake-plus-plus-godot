class_name ScrollableContainer extends Control

var _content_array: Array = []

func initialize() -> void:
	_handle_scroll_arrows()

func _on_ScrollContainer_scroll_ended():
	_handle_scroll_arrows()

func _on_ScrollContainer_scroll_started():
	_handle_scroll_arrows()

func _on_ScrollContainer_gui_input(_event):
	_handle_scroll_arrows()

func _process(_delta):
	if $UpperLimitControl/ScrollUpTextureButton.pressed:
		var max_scroll_value = $ScrollContainer.get_v_scrollbar().max_value - $ScrollContainer.rect_size.y
		var delta = max_scroll_value * 0.05
		var scroll_value = $ScrollContainer.get_v_scrollbar().value
		if scroll_value > delta:
			$ScrollContainer.get_v_scrollbar().value = scroll_value - delta
		else:
			$ScrollContainer.get_v_scrollbar().value = 0
		_handle_scroll_arrows()

	if $LowerLimitControl/ScrollDownTextureButton.pressed:
		var max_scroll_value = $ScrollContainer.get_v_scrollbar().max_value - $ScrollContainer.rect_size.y
		var delta = max_scroll_value * 0.05
		var scroll_value = $ScrollContainer.get_v_scrollbar().value
		if (max_scroll_value - scroll_value) > delta:
			$ScrollContainer.get_v_scrollbar().value = scroll_value + delta
		else:
			$ScrollContainer.get_v_scrollbar().value = max_scroll_value
		_handle_scroll_arrows()

func _handle_scroll_arrows() -> void:
	var max_scroll_value = $ScrollContainer.get_v_scrollbar().max_value - $ScrollContainer.rect_size.y
	var scroll_value = $ScrollContainer.get_v_scrollbar().value
	_handle_arrows_disabled(
		scroll_value == 0,
		scroll_value == max_scroll_value
	)

func _handle_arrows_disabled(up: bool, down: bool) -> void:
	$UpperLimitControl/ScrollUpTextureButton.visible = !up
	$UpperLimitControl/ScrollUpTextureButton.disabled = up
	$LowerLimitControl/ScrollDownTextureButton.visible = !down
	$LowerLimitControl/ScrollDownTextureButton.disabled = down

func append_content(content) -> int:
	_content_array.push_back(content)
	$ScrollContainer/VBoxContainer.add_child(content)
	return _content_array.size() - 1

func get_content() -> Array:
	return _content_array

func clear_content() -> void:
	for content in _content_array:
		$ScrollContainer/VBoxContainer.remove_child(content)
	_content_array = []

func update_content(content_update_strategy: FuncRef) -> void:
	for content in _content_array:
		content_update_strategy.call_func(content)
