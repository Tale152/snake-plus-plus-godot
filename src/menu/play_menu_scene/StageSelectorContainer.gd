class_name StageSelectorContainer extends Control

var challenge_locked = preload("res://assets/menu/play_menu/challenge_container_locked.png")
var challenge_unlocked_0 = preload("res://assets/menu/play_menu/challenge_container_unlocked_0.png")
var challenge_unlocked_1 = preload("res://assets/menu/play_menu/challenge_container_unlocked_1.png")
var challenge_unlocked_2 = preload("res://assets/menu/play_menu/challenge_container_unlocked_2.png")
var challenge_unlocked_3 = preload("res://assets/menu/play_menu/challenge_container_unlocked_3.png")
var arcade_locked = preload("res://assets/menu/play_menu/arcade_container_locked.png")
var arcade_unlocked = preload("res://assets/menu/play_menu/arcade_container_unlocked.png")

var _StageNameFont = preload("res://src/menu/play_menu_scene/StageNameFont.tres")

var _on_pressed_strategy: FuncRef
var _data: MenuStageData
var _text: String

const _DEFAULT_STAGE_NAME_FONT_SIZE: int = 18
const _DEFAULT_STAGE_NAME_OUTLINE_SIZE: int = 2
const _DEFAULT_MIN_X: int = 282
const _DEFAULT_MIN_Y: int = 120

func initialize(
	on_pressed_strategy: FuncRef,
	text: String,
	data: MenuStageData,
	scale: float
) -> void:
	_on_pressed_strategy = on_pressed_strategy
	self.rect_min_size = Vector2(
		_DEFAULT_MIN_X * scale,
		_DEFAULT_MIN_Y * scale
	)
	_StageNameFont.size = _get_int_size(_DEFAULT_STAGE_NAME_FONT_SIZE, scale)
	_StageNameFont.outline_size = _get_int_size(_DEFAULT_STAGE_NAME_OUTLINE_SIZE, scale)
	_data = data
	_text = text
	update_container()

func _get_int_size(default_value: int, scale: float) -> int:
	return int(floor(default_value * scale))

func update_container() -> void:
	$Label.text = _text
	var stage_data: StageData = null
	if PersistentStagesData.get_stages().has(_data.get_uuid()):
		stage_data = PersistentStagesData.get_stages()[_data.get_uuid()]
	
	if stage_data == null:
		$TextureButton.disabled = true
		if PersistentPlaySettings.get_mode() == PersistentPlaySettings.ARCADE:
			$Label.align = Label.ALIGN_CENTER
			$TextureButton.texture_disabled = arcade_locked
		else:
			$Label.align = Label.ALIGN_LEFT
			$TextureButton.texture_disabled = challenge_locked
		return
	
	if PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.PRO:
		if stage_data.get_stars_regular() == 0:
			$TextureButton.disabled = true
				
	if PersistentPlaySettings.get_mode() == PersistentPlaySettings.ARCADE:
		$Label.align = Label.ALIGN_CENTER
		$TextureButton.texture_normal = arcade_unlocked
		$TextureButton.texture_disabled = arcade_locked
	else:
		$Label.align = Label.ALIGN_LEFT
		$TextureButton.texture_disabled = challenge_locked
		if PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.PRO:
			if stage_data.get_stars_pro() == 0:
				$TextureButton.texture_normal = challenge_unlocked_0
			elif stage_data.get_stars_pro() == 1:
				$TextureButton.texture_normal = challenge_unlocked_1
			elif stage_data.get_stars_pro() == 2:
				$TextureButton.texture_normal = challenge_unlocked_2
			else:
				$TextureButton.texture_normal = challenge_unlocked_3
		else:
			if stage_data.get_stars_regular() == 0:
				$TextureButton.texture_normal = challenge_unlocked_0
			elif stage_data.get_stars_regular() == 1:
				$TextureButton.texture_normal = challenge_unlocked_1
			elif stage_data.get_stars_regular() == 2:
				$TextureButton.texture_normal = challenge_unlocked_2
			else:
				$TextureButton.texture_normal = challenge_unlocked_3

func _on_TextureButton_pressed():
	_on_pressed_strategy.call_func(_data, _text)
