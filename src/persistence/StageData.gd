class_name StageData extends Reference

var _stars_regular: int
var _stars_pro: int
var _arcade_record: ArcadeRecord

func _init(stars_regular: int, stars_pro: int, arcade_record: ArcadeRecord):
	_stars_regular = stars_regular
	_stars_pro = stars_pro
	_arcade_record = arcade_record

func get_stars_regular() -> int:
	return _stars_regular

func set_stars_regular(stars: int) -> void:
	_stars_regular = stars

func get_stars_pro() -> int:
	return _stars_pro

func set_stars_pro(stars: int) -> void:
	_stars_pro = stars

func get_arcade_record() -> ArcadeRecord:
	return _arcade_record

func set_arcade_record(arcade_record: ArcadeRecord) -> void:
	_arcade_record = arcade_record
