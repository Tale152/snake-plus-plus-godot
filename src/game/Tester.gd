extends Control

func _ready():
	var parsed_stage : ParsedStage = JsonStageParser.parse("res://assets/stages/treasure.json")
	var controller: GameController = GameController.new(parsed_stage)
