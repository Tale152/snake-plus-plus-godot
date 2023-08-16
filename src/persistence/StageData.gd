class_name StageData extends Reference

var _stars: int
var _arcade_record: ArcadeRecord

func _init(stars: int, arcade_record: ArcadeRecord):
	_stars = stars
	_arcade_record = arcade_record

func get_stars() -> int:
	return _stars

func set_stars(stars: int) -> void:
	_stars = stars

func get_arcade_record() -> ArcadeRecord:
	return _arcade_record

func set_arcade_record(arcade_record: ArcadeRecord) -> void:
	_arcade_record = arcade_record
