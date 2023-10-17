class_name GameOverMenu extends Control

const _ENABLE_BUTTONS_DELAY_SECONDS: float = 2.7
const _COINS_EARNED_LABEL_DEFAULT_FONT_SIZE = 20
const _GAME_OVER_LABEL_DEFAULT_FONT_SIZE = 30
const _NEW_HIGHSCORE_LABEL_DEFAULT_FONT_SIZE = 18
const _BUTTONS_DEFAULT_FONT_SIZE = 18

var _on_play_again_button_pressed_strategy: FuncRef
var _on_back_to_menu_button_pressed_strategy: FuncRef

func set_on_play_again_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_play_again_button_pressed_strategy = strategy

func set_on_back_to_menu_button_pressed_strategy(strategy: FuncRef) -> void:
	_on_back_to_menu_button_pressed_strategy = strategy

func set_result(game_over_data: GameOverData) -> void:
	if game_over_data.get_added_coins() > 0:
		$CoinsEarnedTextureButton.visible = true
		$CoinsEarnedLabel.visible = true
		$CoinsEarnedLabel.text = "+" + str(game_over_data.get_added_coins())
	else:
		$CoinsEarnedTextureButton.visible = false
		$CoinsEarnedLabel.visible = false
	
	if PersistentPlaySettings.is_arcade_mode():
		$ArcadeGameOverContainerControl/NewHighscoreLabel.text = TranslationsManager.get_localized_string(TranslationsManager.NEW_HIGHSCORE)
		$ArcadeGameOverContainerControl.visible = true
		$ArcadeGameOverContainerControl/NewHighscoreLabel.visible = game_over_data.is_highscore()
		$ChallengeGameOverContainerControl.visible = false
	else:
		$ChallengeGameOverContainerControl/NewHighscoreLabel.text = TranslationsManager.get_localized_string(TranslationsManager.NEW_HIGHSCORE)
		$ArcadeGameOverContainerControl.visible = false
		$ChallengeGameOverContainerControl.visible = true
		$ChallengeGameOverContainerControl/BestScoreStarsIndicatorControl.set_stars_number(game_over_data.get_stars())
		$ChallengeGameOverContainerControl/NewHighscoreLabel.visible = game_over_data.is_highscore()
	
func show() -> void:
	self.visible = true
	WaitTimer.new() \
		.set_seconds(_ENABLE_BUTTONS_DELAY_SECONDS) \
		.set_parent_node(self) \
		.set_callback(funcref(self, "_enable_buttons")) \
		.wait()

func scale_font(scale: float) -> void:
	ScalingHelper.scale_button_text($PlayAgainButton, _BUTTONS_DEFAULT_FONT_SIZE, scale)
	ScalingHelper.scale_button_text($BackToMenuButton, _BUTTONS_DEFAULT_FONT_SIZE, scale)
	ScalingHelper.scale_label_text($ArcadeGameOverContainerControl/GameOverLabel, _GAME_OVER_LABEL_DEFAULT_FONT_SIZE, scale)
	ScalingHelper.scale_label_text($ArcadeGameOverContainerControl/NewHighscoreLabel, _NEW_HIGHSCORE_LABEL_DEFAULT_FONT_SIZE, scale)
	ScalingHelper.scale_label_text($ChallengeGameOverContainerControl/GameOverLabel, _GAME_OVER_LABEL_DEFAULT_FONT_SIZE, scale)
	ScalingHelper.scale_label_text($ChallengeGameOverContainerControl/NewHighscoreLabel, _NEW_HIGHSCORE_LABEL_DEFAULT_FONT_SIZE, scale)
	ScalingHelper.scale_label_text($CoinsEarnedLabel, _COINS_EARNED_LABEL_DEFAULT_FONT_SIZE, scale)

func _enable_buttons() -> void:
	$PlayAgainButton.disabled = false
	$BackToMenuButton.disabled = false

func _on_PlayAgainButton_pressed():
	_on_play_again_button_pressed_strategy.call_func()

func _on_BackToMenuButton_pressed():
	_on_back_to_menu_button_pressed_strategy.call_func()
