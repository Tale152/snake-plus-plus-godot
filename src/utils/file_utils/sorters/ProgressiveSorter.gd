class_name ProgressiveSorter extends Reference

func sort(x_filename: String, y_filename: String) -> bool:
	var x_progr: int = int(x_filename.get_slice("-", 0).strip_edges(true, true))
	var y_progr: int = int(y_filename.get_slice("-", 0).strip_edges(true, true))
	return x_progr < y_progr
