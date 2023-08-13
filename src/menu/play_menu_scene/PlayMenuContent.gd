class_name PlayMenuContent extends Control

var stages: Array = []

func scale(scale: float) -> void:
	$PlayModeSetterControl.scale(scale)
	$ArcadeDifficultySetterControl.scale(scale)

func initialize(main_scene_instance) -> void:
	$PlayModeSetterControl.initialize(main_scene_instance)
	$ArcadeDifficultySetterControl.initialize(main_scene_instance)

func append_stage(stage) -> int:
	stages.push_back(stage)
	$ScrollContainer/VBoxContainer.add_child(stage)
	return stages.size() - 1

func clear_stages() -> void:
	for stage in stages:
		$ScrollContainer/VBoxContainer.remove_child(stage)
	stages = []
