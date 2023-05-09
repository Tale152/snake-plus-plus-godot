class_name MenuScene extends Control

onready var _NavigationBar = $SafeAreaControl/RectangleAspectRatioContainer/MenuSceneContainerControl/NavigationBarContainerControl/NavigationBarControl
onready var _ContentContainerControl = $SafeAreaControl/RectangleAspectRatioContainer/MenuSceneContainerControl/ContentContainerControl

func get_navigation_bar() -> NavigationBar:
	return _NavigationBar
