extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var hovered = false
var held = false
var offset: Vector2
const DRAG_SPEED = 75.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hovered and held:
		var mouse_pos = get_global_mouse_position() + offset
		var weight = 1 - exp(-DRAG_SPEED * delta)
		position = (position.lerp(mouse_pos, weight))
		pass
	pass

func _on_mouse_entered() -> void:
	hovered = true
	print(self.name + " hovered!")
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	if !held:
		hovered = false
	pass # Replace with function body.

func _on_gui_input(event: InputEvent) -> void:
	#print("InputEvent: " + event.as_text())
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed():
		held = true
		offset = get_local_mouse_position().abs() * -1
		print("Held")
		pass
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_released():
		held = false
		print("Released")
		pass

		
	pass # Replace with function body.
