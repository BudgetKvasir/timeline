extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	editable = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_edit_button_pressed() -> void:
	editable = true
	focus_mode = Control.FOCUS_ALL
	grab_focus.call_deferred()
	pass # Replace with function body.


func _on_text_submitted(_new_text: String) -> void:
	editable = false
	focus_mode = Control.FOCUS_NONE
	release_focus.call_deferred()
	pass # Replace with function body.
