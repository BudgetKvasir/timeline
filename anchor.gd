extends Area2D

signal clicked(anchor: Area2D)
signal entered(anchor: Area2D)
signal exited

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
		clicked.emit(self)
		#print("Mouse click on anchor %s @ %s" % [self.name, self.position])
		pass
	pass # Replace with function body.


func _on_mouse_entered() -> void:
	entered.emit(self)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	exited.emit()
	pass # Replace with function body.
