extends Control

signal drag(dragging)

var AnchorNode: PackedScene = preload("res://anchor.tscn")
var hovered = false
var held = false
var placing = true
var placing_line = false
var offset: Vector2
const DRAG_SPEED = 75.0
var markers = true
var anchor_points: Array
var anchors: Array
# Sets the ratio to full x/y dimension that anchors will be at, 0.5 = anchor @ size*0.5
const ANCHOR_REF: Array = [0, 0.5, 1] 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var debug_toggle = get_tree().root.get_node("/root/Main/MenuHUD/MenuMargin/MenuBar/Buttons/Debug")
	debug_toggle.toggled.connect(_on_debug_toggled)
	
	for i in range(9):
		anchor_points.append(Vector2(0,0))
		var anchor = AnchorNode.instantiate()
		anchor.position = Vector2(0,0)
		anchor.name = "%s_Anchor%s" % [self.name, i]
		anchors.append(anchor)
		$AnchorOverlay.add_child(anchor)
	#for point in anchor_points:
		
	update_anchors()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if placing:
		var mouse_pos = get_global_mouse_position()
		var place_offset = size / 2
		position = mouse_pos - place_offset
		pass
	
	if hovered and held and !placing:
		var mouse_pos = get_global_mouse_position() + offset
		var weight = 1 - exp(-DRAG_SPEED * delta)
		position = (position.lerp(mouse_pos, weight))
		pass
	
	pass

# update_anchors gets local coordinates for anchor locations, 
# adding the resulting Vector2 for the desired anchor point to the card's 
# position gets you the global position for the anchor point
func update_anchors(_enabled: bool = false) -> void: 
	for i in anchor_points.size():
		@warning_ignore("integer_division") # Discarding the decimal is desired
		anchor_points[i] = Vector2(size.x*ANCHOR_REF[i%3], size.y*ANCHOR_REF[i/3])
		anchors[i].position = anchor_points[i]
		#print("anchor_point: %14s anchor_pos: %14s" % [anchor_points[i], anchors[i].position])
	#print(anchor_points)
	pass

func get_anchors() -> Array:
	return anchor_points

func toggle_anchors(toggled_on: bool):
	for anchor in anchors:
		anchor.input_pickable = toggled_on
		
		print(anchor.input_pickable)

func get_main_debug() -> bool:
	return get_tree().root.get_node("/root/Main").Debug

func _on_debug_toggled(toggled_on: bool):
	toggle_anchors(toggled_on)
	pass

func _on_mouse_entered() -> void:
	hovered = true
	#print(self.name + " hovered!")
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	if !held:
		hovered = false
	pass # Replace with function body.

func _on_gui_input(event: InputEvent) -> void:
	#print("InputEvent: " + event.as_text())
	if placing and (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed():
		#print("Done placing!")
		placing = false
		pass
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed() and !placing:
		held = true
		offset = get_local_mouse_position().abs() * -1
		drag.emit(held and hovered)
		#print("Held")
		pass
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_released() and !placing:
		held = false
		drag.emit(held and hovered)
		#print("Released")
		pass
	pass # Replace with function body.

func _on_resized() -> void:
	update_anchors()
	pass # Replace with function body.
