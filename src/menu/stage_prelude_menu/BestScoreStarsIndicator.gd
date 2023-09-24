class_name BestScoreStarsIndicator extends Control

func set_stars_number(n: int) -> void:
	$FirstStarTextureButton.disabled = n < 1
	$SecondStarTextureButton.disabled = n < 2
	$ThirdStarTextureButton.disabled = n < 3
