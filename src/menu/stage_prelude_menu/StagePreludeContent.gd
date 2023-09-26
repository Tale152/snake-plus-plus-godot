class_name StagePreludeContent extends Control

const _StagePreludeChallengeContent = preload("res://src/menu/stage_prelude_menu/StagePreludeChallengeContent.tscn")
const _StagePreludeArcadeContent = preload("res://src/menu/stage_prelude_menu/StagePreludeArcadeContent.tscn")

const STAGE_NAME_DEFAULT_FONT_SIZE: int = 20
const PLAY_BUTTON_DEFAULT_FONT_SIZE: int = 20

var _data: MenuStageData
var _on_play_pressed: FuncRef
var _selected_mode_scene: Control

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
	elif PersistentPlaySettings.is_arcade_mode():
		_selected_mode_scene = _StagePreludeArcadeContent.instance()
		_selected_mode_scene.initialize(_data.get_uuid())
	$SelectedModeContentControl.add_child(_selected_mode_scene)
	SceneCreation.set_anchors_full_rect(_selected_mode_scene)
	_on_play_pressed = on_play_pressed

func scale(scale: float) -> void:
	ScalingHelper.scale_label_text($StageNameLabel, STAGE_NAME_DEFAULT_FONT_SIZE, scale)
	ScalingHelper.scale_button_text($PlayButton, PLAY_BUTTON_DEFAULT_FONT_SIZE, scale)
	_selected_mode_scene.scale_text(scale)

func _on_PlayButton_pressed():
	_on_play_pressed.call_func(_data)
