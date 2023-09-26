class_name StagePreludeContent extends Control

var _ArcadeStageInfoFont = preload("res://src/menu/stage_prelude_menu/ArcadeStageInfoFont.tres")
var _ArcadeStageInfoButtonFont = preload("res://src/menu/stage_prelude_menu/ArcadeStageInfoButtonFont.tres")

const _StagePreludeChallengeContent = preload("res://src/menu/stage_prelude_menu/StagePreludeChallengeContent.tscn")

var STAGE_NAME_DEFAULT_FONT_SIZE: int = 20

var _data: MenuStageData
var _on_play_pressed: FuncRef

var _selected_mode_scene

func initialize(
	data: MenuStageData, name: String, on_play_pressed: FuncRef
) -> void:
	_data = data
	$StageNameLabel.text = name
	_selected_mode_scene = null
	SceneCreation.delete_children($SelectedModeContentControl)
	if PersistentPlaySettings.is_challenge_mode():
		_selected_mode_scene = _StagePreludeChallengeContent.instance()
		_selected_mode_scene.initialize(_data.get_uuid(), data.get_stage_path())
	# TODO else
	$SelectedModeContentControl.add_child(_selected_mode_scene)
	SceneCreation.set_anchors_full_rect(_selected_mode_scene)
	_on_play_pressed = on_play_pressed

func scale(scale: float) -> void:
	_ArcadeStageInfoFont.size = STAGE_NAME_DEFAULT_FONT_SIZE * scale
	_ArcadeStageInfoButtonFont.size = 20 * scale
	_selected_mode_scene.scale_text(scale)

func _on_PlayButton_pressed():
	_on_play_pressed.call_func(_data)
