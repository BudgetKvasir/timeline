extends Node2D

var placing: bool = false
var anchor_hovered: bool = false
var active_line: Line2D
var all_lines: Array[Line2D]

# Need to store the anchors as a reference instead, give the lines two anchors and when
# Card emits the drag signal updatle the line's position to keep matching the anchors position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if placing and !anchor_hovered and active_line != null:
		var mouse_pos = get_global_mouse_position()
		set_active_point_pos(mouse_pos)
		
	pass

func set_active_point_pos(pos: Vector2) -> void:
	active_line.set_point_position(active_line.get_point_count()-1, pos)
	pass

func add_new_line(start: Vector2) -> void:
	var new_line = Line2D.new()
	new_line.z_index = -1
	new_line.add_point(start)
	new_line.add_point(start)
	all_lines.append(new_line)
	add_child(new_line)
	pass

#func _input(event: InputEvent) -> void:
	#if CustomTools.check_left_click(event) and !placing and anchor_hovered:
		#placing = true
		#var new_line = Line2D.new()
		#new_line.z_index = -1
		#new_line.add_point(Vector2(0,0))
		#all_lines.append(new_line)
		#add_child(new_line)
		#pass
	#pass

#### Signals ####
func _on_add_line_pressed() -> void:
	placing = true
	pass # Replace with function body.

func _on_anchor_clicked(anchor: Area2D) -> void: # Make a new point to server as the active one
	# Check if we have an active line yet and if we are placing one, if not add one starting at 
		# the clicked anchors pos
	# If we do have a line started and are placing then stop placing and set active line to null
	print(anchor.name)
	if active_line == null and placing:
		add_new_line(anchor.global_position)
		active_line = all_lines.back()
	elif active_line != null and placing:
		set_active_point_pos(anchor.global_position)
		placing = false
		active_line = null
		pass
	
func _on_anchor_entered(anchor: Area2D) -> void:
	anchor_hovered = true
	if placing and active_line != null:
		set_active_point_pos(anchor.global_position)
	pass
	
func _on_anchor_exited() -> void:
	anchor_hovered = false
	pass
