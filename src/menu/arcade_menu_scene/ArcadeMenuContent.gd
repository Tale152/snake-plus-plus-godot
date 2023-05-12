class_name ArcadeMenuContent extends Control

var stages: Array = []

func append_stage(stage) -> int:
	stages.push_back(stage)
	$ScrollContainer/VBoxContainer.add_child(stage)
	return stages.size() - 1

func clear_stages() -> void:
	for stage in stages:
		$ScrollContainer/VBoxContainer.remove_child(stage)
	stages = []
