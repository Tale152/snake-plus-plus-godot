class_name Effects extends Control

const EffectStatus = preload("res://src/game/view/effects/EffectStatus.tscn")
const _DEFAULT_HEIGHT_PX: float = 31.2
const _DEFAULT_WIDTH_PX: float = 282.0
const _EFFECT_WIDTH_PERCENTAGE: float = 0.11
const _LEFT_MARGIN_PERCENTAGE: float = 0.0
const _MAX_EFFECTS_ODD: int = 9
const _MAX_EFFECTS_EVEN: int = 8

var _possible_effect_status: Dictionary = {}
var _possible_effects: Array = []
var _currently_printed_effects: Array = []
var _real_heigth_px: float
var _real_width_px: float

func initialize(
	effects: Dictionary, # key = EffectType, value = AnimatedSprite
	scale: float
):
	_real_heigth_px = _DEFAULT_HEIGHT_PX * scale
	_real_width_px = _DEFAULT_WIDTH_PX * scale
	for e in effects.keys():
		_possible_effects.push_back(e)
		var es = EffectStatus.instance()
		es.initialize(effects[e], _real_heigth_px)
		_possible_effect_status[e] = es

func render(equipped_effects_timers: Array) -> void:
	var to_be_removed = _possible_effects.duplicate(false)
	if equipped_effects_timers.size() > 0:
		var margins: Array = _get_margins_array(equipped_effects_timers.size())
		var i: int = 0
		for timer in equipped_effects_timers:
			var type = timer.get_effect_type()
			to_be_removed.erase(type)
			var es: EffectStatus = _possible_effect_status[type]
			if !_currently_printed_effects.has(type):
				_currently_printed_effects.push_back(type)
				add_child(es)
				es.start_sprite_animation()
			var effect_margins = margins[i]
			es.render(effect_margins[0], effect_margins[1], timer.get_percentage())
			i += 1
	for effect_to_remove in to_be_removed:
		if _currently_printed_effects.has(effect_to_remove):
			_currently_printed_effects.erase(effect_to_remove)
			remove_child(_possible_effect_status[effect_to_remove])

func _get_margins_array(equipped_effects_number: int) -> Array:
	var result = []
	var left_margin: float
	var left_skip: int
	if equipped_effects_number % 2 == 0:
		left_margin = _LEFT_MARGIN_PERCENTAGE + (_EFFECT_WIDTH_PERCENTAGE / 2)
		left_skip = (_MAX_EFFECTS_EVEN - equipped_effects_number) / 2
	else:
		left_margin = _LEFT_MARGIN_PERCENTAGE
		left_skip = (_MAX_EFFECTS_ODD - equipped_effects_number) / 2
	for i in range(0, equipped_effects_number, 1):
		var effect_left_margin = left_margin + ((left_skip + i) * _EFFECT_WIDTH_PERCENTAGE)
		result.push_back(
			[effect_left_margin, effect_left_margin + _EFFECT_WIDTH_PERCENTAGE]
		)
	return result
