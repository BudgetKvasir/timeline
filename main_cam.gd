extends Camera2D

var arrow_speed = 5
var edge_speed = 10
var edge_range = 50
var speed_mod = 1
var top_margin
var bottom_margin
var left_margin
var right_margin

# Get viewport size, track mouse pos and if it's within a certain distance of the edge of the view port
# move the camera in that direction
@onready var view_size = get_viewport().get_visible_rect().size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_margin = edge_range
	bottom_margin = view_size.y - edge_range
	left_margin = edge_range
	right_margin = view_size.x - edge_range
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	 # bottom_margin=785 mouse.y=790 want speed_mod=.3333333333333 (etc.)
		# (mouse.y-bottom_margin) / edge_range
	# top_margin=15 mouse.y=10 want speed_mod=.33333
		# (top_margin - mouse.y) / edge_range
	var mouse_pos = get_local_mouse_position()
# # # # # # Vertical edge detection # # # # # # #
	if mouse_pos.y < top_margin: 
		speed_mod = (top_margin - mouse_pos.y) / edge_range
		position.y -= edge_speed * speed_mod
	if mouse_pos.y > bottom_margin:
		speed_mod = (mouse_pos.y - bottom_margin) / edge_range
		position.y += edge_speed * speed_mod
 # # # # # Horizontal edge detection # # # # # #
	if mouse_pos.x < left_margin:
		speed_mod = (left_margin - mouse_pos.x) / edge_range
		position.x -= edge_speed * speed_mod
	if mouse_pos.x > right_margin:
		speed_mod = (mouse_pos.x - right_margin) / edge_range
		position.x += edge_speed * speed_mod
	# Camera controls with arrow keys w/ modifier
	if Input.is_action_pressed("speed"):
		speed_mod = 2
	if Input.is_action_pressed("mv_left"):
		position.x -= arrow_speed * speed_mod
	if Input.is_action_pressed("mv_right"):
		position.x += arrow_speed * speed_mod
	if Input.is_action_pressed("mv_up"):
		position.y -= arrow_speed * speed_mod
	if Input.is_action_pressed("mv_down"):
		position.y += arrow_speed * speed_mod
	speed_mod = 1
	pass
