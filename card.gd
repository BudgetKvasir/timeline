extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var hovered = false
var held = false
var placing = true
var offset: Vector2
const DRAG_SPEED = 75.0

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
		print("Done placing!")
		placing = false
		pass
	
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed() and !placing:
		held = true
		offset = get_local_mouse_position().abs() * -1
		get_parent().set_drag((held and hovered))
		#print("Held")
		pass
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_released() and !placing:
		held = false
		get_parent().set_drag((held and hovered))
		#print("Released")
		pass

		
	pass # Replace with function body.
