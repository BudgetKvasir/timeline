extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_pickable = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()
	pass

func _draw() -> void:
	if input_pickable:
		draw_circle(Vector2(0,0), 10, Color.WHITE, true)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed():
		print("Mouse click on anchor %s @ %s" % [self.name, self.position])
		pass
	pass # Replace with function body.
