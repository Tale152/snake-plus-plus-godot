class_name SceneCreation extends Reference

static func set_anchors(
	scene: Control, top: float, right: float, bottom: float, left: float
) -> void:
	scene.anchor_top = top
	scene.anchor_right = right
	scene.anchor_bottom = bottom
	scene.anchor_left = left

static func set_anchors_full_rect(scene: Control) -> void:
	set_anchors(scene, 0, 1, 1, 0)

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
