class_name EffectStrategy extends Reference
# is ment to be used as an Interface

func execute_apply_effect(snake_properties: SnakePropertiesTODO) -> void:
	push_error(
		"You called the execute_apply_effect function of EffectStrategy, " + 
		"which is ment to be used as an interface"
	)

func execute_revoke_effect(snake_properties: SnakePropertiesTODO) -> void:
	push_error(
		"You called the execute_revoke_effect function of EffectStrategy, " + 
		"which is ment to be used as an interface"
	)
