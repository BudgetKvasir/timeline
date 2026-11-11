extends Panel

var debug: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var debug_toggle = get_tree().root.get_node("/root/Main/MenuHUD/MenuMargin/MenuBar/Buttons/Debug")
	debug_toggle.toggled.connect(_on_debug_toggled)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_debug_toggled(toggled_on: bool):
	debug = toggled_on
	queue_redraw()
	pass
	
# Draws anchor points if debug is on (if Main.Debug == true)
func _draw() -> void:
	if debug:
		for i in get_parent().anchors.size():
			draw_circle(get_parent().anchors[i], 4, Color.DARK_CYAN, true, -1.0, true)
			pass
		pass
	pass
