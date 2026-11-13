class_name CustomTools
extends Node


static func check_left_click(event: InputEvent) -> bool:
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed():
		return true
	return false
