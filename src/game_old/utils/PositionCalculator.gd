class_name PositionCalculator

static func calculate_position(
	coordinates: ImmutablePoint,
	px_size: int,
	offset: Vector2
) -> Vector2:
	return Vector2(
		coordinates.get_x() * px_size + offset.x,
		coordinates.get_y() * px_size + offset.y
	)
