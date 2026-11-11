extends Node

@export var Card: PackedScene
@export var Debug: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuHUD/MenuMargin/MenuBar/Buttons/Debug.button_pressed = Debug
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass
	
func _on_add_card_button_up() -> void:
	var card = Card.instantiate()
	add_child(card)
	card.drag.connect($MainCam._on_drag)
	pass # Replace with function body.


func _on_debug_toggled(toggled_on: bool) -> void:
	Debug = toggled_on
	pass # Replace with function body.
