extends Node

@export var Card: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_drag(drag: bool):
	$MainCam.drag = drag
	pass

func _on_add_card_button_up() -> void:
	var card = Card.instantiate()
	add_child(card)
	pass # Replace with function body.
