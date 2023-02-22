class_name DictionaryUtil extends Reference

static func contains(d: Dictionary, value: String, type: int) -> bool:
	return d.has(value) && typeof(d[value]) == type

static func does_not_contain(d: Dictionary, value: String) -> bool:
	return !d.has(value)
