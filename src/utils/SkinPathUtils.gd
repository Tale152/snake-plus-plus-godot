class_name SkinPathUtils extends Reference

const _SKIN_ROOT_PATH: String = "res://assets/skins"
const _PERKS_ROOT_PATH: String = "res://assets/game/perks"
const _FIELD_ROOT_PATH: String = "res://assets/game/field"
const _HUD_ROOT_PATH: String = "res://assets/game/hud"

static func get_skin_path(uuid: String) -> String:
	var skin_packages: Array = FileUtils.get_directories_list(_SKIN_ROOT_PATH)
	for package in skin_packages:
		var info_file_path = package + "/stage_info.json"
		var info_file_json: Dictionary = FileUtils.get_json_file_content(info_file_path)
		if info_file_json.uuid == uuid:
			return package
	print("ERROR RETRIEVING SKIN PATH FOR UUID: " + uuid)
	return "ERROR"

static func get_perks_root_path() -> String:
	return _PERKS_ROOT_PATH

static func get_field_root_path() -> String:
	return _FIELD_ROOT_PATH

static func get_hud_root_path() -> String:
	return _HUD_ROOT_PATH
