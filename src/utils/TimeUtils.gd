class_name TimeUtils extends Node

static func seconds_to_minutes_seconds(seconds: float) -> String:
	return str(int(seconds / 60)) + ":" + str(int(seconds) % 60).pad_zeros(2)
