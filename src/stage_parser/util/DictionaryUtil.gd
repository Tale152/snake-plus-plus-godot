class_name DictionaryUtil extends Reference

static func contains(d: Dictionary, value: String, type: int):
	return d.has(value) && typeof(d[value]) == type
