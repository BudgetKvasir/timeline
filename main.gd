extends Node

@export var Card: PackedScene
@export var Debug: bool = false
var card_index: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuHUD/MenuMargin/MenuBar/Buttons/Debug.button_pressed = Debug
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass
	
func _on_add_card_button_up() -> void:
	var card = Card.instantiate()
	card.name = "Card%d" % card_index
	card.drag.connect($MainCam._on_drag)
	add_child(card)
	card_index += 1
	pass # Replace with function body.


func _on_debug_toggled(toggled_on: bool) -> void:
	Debug = toggled_on
	pass # Replace with function body.
