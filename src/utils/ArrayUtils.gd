class_name ArrayUtils extends Reference

static func get_array_index(arr: Array, elem) -> int:
	var i = 0
	for v in arr:
		if elem == v: return i
		i += 1
	return -1
