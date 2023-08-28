extends Control

func _ready():
	update()

func update() -> void:
	if PersistentPlaySettings.get_mode() == PersistentPlaySettings.CHALLENGE:
		var stages_number: int = StagesHelper.new().list_stage_files().size()
		var total_stars: String = str(stages_number * 3)
		var obtained_stars: String = _get_obtained_stars()
		$SummaryRichLabel.text = obtained_stars + " / " + total_stars
	else:
		$SummaryRichLabel.text = _get_total_length_reached()

func _get_obtained_stars() -> String:
	var stages_data: Dictionary = PersistentStagesData.get_stages()
	var is_regular: bool = PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.REGULAR
	var total: int = 0
	for uuid in stages_data.keys():
		var data: StageData = stages_data[uuid]
		if is_regular && data.get_stars_regular() != null:
			total += data.get_stars_regular()
		elif data.get_stars_pro() != null:
			total += data.get_stars_pro()
	return str(total)

func _get_total_length_reached() -> String:
	var stages_data: Dictionary = PersistentStagesData.get_stages()
	var is_regular: bool = PersistentPlaySettings.get_difficulty() == PersistentPlaySettings.REGULAR
	var total: int = 0
	for uuid in stages_data.keys():
		var data: StageData = stages_data[uuid]
		if is_regular && data.get_regular_record() != null:
			total += data.get_regular_record().get_length()
		elif data.get_pro_record() != null:
			total += data.get_pro_record().get_length()
	return str(total)
