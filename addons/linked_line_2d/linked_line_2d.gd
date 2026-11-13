@tool

@icon("res://theme/Line2D.svg")

class_name LinkedLine2D
extends Line2D

enum {START, END}

var start: Area2D
var end: Area2D

func update_points() -> void:
	if start != null and end != null:
		set_point_position(0, start.global_position)
		set_point_position(1, end.global_position)
	pass

func add_anchor(anchor: Area2D, index: int = -1):
	assert(index<2, "add_anchor: Invalid index value, '%s', index must be 0 or 1.")
	if index == START:
		start = anchor
	elif index == END:
		end = anchor
	pass

func add_point(point: Vector2, index: int = -1):
	if 
	pass

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
