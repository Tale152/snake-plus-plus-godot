class_name MenuScene extends Control

onready var _NavigationBar = $SafeAreaControl/RectangleAspectRatioContainer/MenuSceneContainerControl/NavigationBarContainerControl/NavigationBarControl
onready var _ContentContainerControl = $SafeAreaControl/RectangleAspectRatioContainer/MenuSceneContainerControl/ContentContainerControl

func _ready():
	_NavigationBar.scale(get_scaling())

func get_navigation_bar() -> NavigationBar:
	return _NavigationBar

func get_scaling() -> float:
	var project_height = ProjectSettings.get("display/window/size/height")
	var project_width = ProjectSettings.get("display/window/size/width")
	var original_ratio = project_height / project_width
	var screen_size = get_tree().get_root().size
	var runtime_ratio = screen_size.y / screen_size.x
	if runtime_ratio >= original_ratio:
		return screen_size.x / project_width
	else:
		return screen_size.y / project_height
