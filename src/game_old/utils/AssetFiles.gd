class_name AssetFiles

static func build_asset_path(dir: String, name: String, number: int) -> String:
	return str(dir, "/", name, "_", number, ".png")

static func asset_exists(path: String) -> bool:
	return Directory.new().file_exists(str(path, ".import"))

static func load_asset(path: String) -> Resource:
	return load(path)
