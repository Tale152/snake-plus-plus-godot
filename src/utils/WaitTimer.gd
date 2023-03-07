class_name WaitTimer extends Reference

var _seconds: float
var _parent_node: Node
var _callback: FuncRef

func set_seconds(s: float) -> WaitTimer:
	_seconds = s
	return self

func set_parent_node(n: Node) -> WaitTimer:
	_parent_node = n
	return self

func set_callback(c: FuncRef) -> WaitTimer:
	_callback = c
	return self

func wait() -> void:
	var t = Timer.new()
	t.set_wait_time(_seconds)
	t.set_one_shot(true)
	_parent_node.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	_callback.call_func()
