extends Camera2D

const arrow_speed = 5
const scroll_speed = 15
@export var edge_range := Vector2(50, 50)
var scroll_speed_mod := Vector2(1,1)
var speed_mod = 1
var zoom_speed = Vector2(0.01,0.01)
var drag = false
var start_pos
var start_zoom


# Get viewport size, track mouse pos and if it's within a certain distance of the edge of the view port
# move the camera in that direction
@onready var view_size = get_viewport().get_visible_rect().size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = position
	start_zoom = zoom
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	 # bottom_margin=785 mouse.y=790 want speed_mod=.3333333333333 (etc.)
		# (mouse.y-bottom_margin) / edge_range
	# top_margin=15 mouse.y=10 want speed_mod=.33333
		# (top_margin - mouse.y) / edge_range
	if Input.is_action_just_released("wheel_scroll_up"): # Zoom in
		#print(zoom)
		if zoom.x < 3 :
			zoom_cam(zoom_speed)
		#print("Scroll up")
		pass
	if Input.is_action_just_released("wheel_scroll_down"): # Zoom out
		#print(zoom)
		if (zoom.x - zoom_speed.x) > 0.0:
			zoom_cam(-zoom_speed)
		#print("scroll down")
		pass
	
	
	

	# Checks for enable key held or if a card is being dragged towards the edge of the screen 
	if Input.is_action_pressed("edge_scroll_enable") or drag:
		#var debug_msg = ""
		var mouse_pos = get_clamped_mouse_position()
		update_scroll_speed_mod(mouse_pos)
		if mouse_pos.x < edge_range.x: # Move left
			position.x -= scroll_speed * scroll_speed_mod.x
			#debug_msg += format_debug("left", mouse_pos)
		if mouse_pos.x > view_size.x - edge_range.x: # Move right
			position.x += scroll_speed * scroll_speed_mod.x
			#debug_msg += format_debug("right", mouse_pos)
		if mouse_pos.y < edge_range.y: # Move up
			position.y -= scroll_speed * scroll_speed_mod.y
			#debug_msg += format_debug("top", mouse_pos)
		if mouse_pos.y > view_size.y - edge_range.y: # Move Down
			position.y += scroll_speed * scroll_speed_mod.y
			#debug_msg += format_debug("bottom", mouse_pos)
		#print(debug_msg)
		pass
	
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
	
func zoom_cam(delta: Vector2) -> void:
	var mouse_pos = get_global_mouse_position()
	zoom += delta
	var new_mouse_pos = get_global_mouse_position()
	position += mouse_pos - new_mouse_pos
	pass

func get_clamped_mouse_position() -> Vector2:
	var mouse_pos = get_viewport().get_mouse_position()
	if mouse_pos.x < 0: mouse_pos.x = 0
	if mouse_pos.x > view_size.x: mouse_pos.x = view_size.x
	if mouse_pos.y < 0: mouse_pos.y = 0
	if mouse_pos.y > view_size.y: mouse_pos.y = view_size.y
	return mouse_pos

# Need mouse position, view_size and edge_range
func update_scroll_speed_mod(mouse_pos: Vector2) -> void:
	var edge_start := Vector2(view_size - Vector2(50, 50))
	var edge_distance := Vector2(0,0)
	edge_distance.x = mouse_pos.x - edge_start.x if mouse_pos.x > 50 else edge_range.x - mouse_pos.x
	edge_distance.y = mouse_pos.y - edge_start.y if mouse_pos.y > 50 else edge_range.y - mouse_pos.y
	scroll_speed_mod = edge_distance / edge_range
	
	pass

func format_debug(dir: String, pos: Vector2) -> String: # dir N/S/E/W ; pos mouse_pos
	var format_string = "{dir} : {dis}/{rng} {per}\n"
	var dis: float # Distance from the edge of the screen, starting from edge of detection range
	var rng: float # Detection range from edge of screen (edge_range short hand)
	match dir:
		"left", "right":
			dis = pos.x - (view_size.x - edge_range.x) if pos.x > 50 else edge_range.x - pos.x
			# dis = pos.x - (view_size.x - edge_range.x) if dir == "right" else pos.x
			rng = edge_range.x
		"top", "bottom":
			dis = pos.y - (view_size.y - edge_range.y) if dir == "bottom" else edge_range.y - pos.y
			rng = edge_range.y
	return format_string.format({"dir": "%6s" % dir, "dis": "%05.2f" % dis, "rng": "%03d" % rng, "per": "%03.2f" % (dis / rng)})

func _on_cam_pos_reset_pressed() -> void:
	position = start_pos
	zoom = start_zoom
	pass # Replace with function body.

func _on_track_pad_toggled(toggled_on: bool) -> void:
	if toggled_on:
		zoom_speed = Vector2(0.04,0.04)
	if !toggled_on:
		zoom_speed = Vector2(0.01,0.01)
	pass # Replace with function body.

func _on_drag(dragging: bool) -> void:
	drag = dragging
	pass
