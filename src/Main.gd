extends Node

const APPLE = preload("res://src/game/edibles/Apple.tscn")

func _ready():
	var apple_instance = APPLE.instance()
	add_child(apple_instance)
	apple_instance.spawn(Vector2(randi()%500+1, randi()%500+1), $Snake)
	$Timer.start()

func _on_Timer_timeout():
	var apple_instance = APPLE.instance()
	add_child(apple_instance)
	apple_instance.spawn(Vector2(randi()%500+1, randi()%500+1), $Snake)
