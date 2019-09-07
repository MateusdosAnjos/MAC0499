extends Node2D

var starting_pos = null
var visual_inputs = []
var start_input = ''
var curve = Curve2D.new()
var next_value = 0
var total_inputs = 0

onready var ValueNode = get_node("Path/PathFollow2D/Value")

func _ready():
    $Path.hide()

#Sets the first point of the path  
func _on_InputOutput_start_input_position(pos):
    starting_pos = (Vector2(pos[0], pos[1]-50))
    start_input = get_parent().INPUT

#Creates the curve, using the positions of the action spaces,
#that visual process will follow (the offsets are used to make it better to view)
func _on_RunEnvironment_visual_process_arguments(path_points, intermediate_inputs):
    visual_inputs = intermediate_inputs
    total_inputs = len(visual_inputs)
    curve.clear_points()
    $Path.set_curve(curve)
    var curve_points = []
    curve_points.append(starting_pos)
    
    for point in path_points:
       curve_points.append(Vector2(point[0], point[1]))
    
    var last_point = curve_points[len(curve_points)-1]
    last_point[0] += 120
    curve_points.append(last_point)
    
    for point in curve_points:
        point[1] += 50
        curve.add_point(point)

#Changes the text on Value, based on the output of the given
#Action space
func _on_MovableActionSpace_change_area_entered():
    ValueNode.text = str(visual_inputs[next_value])
    next_value = (next_value + 1) % total_inputs
    
#Sets the start value of the process
func _on_InputOutput_start_input_visual_entered():
    ValueNode.text = str(start_input)
    
#Sets the curve to follow and starts it
func _on_RunEnvironment_set_curve():
    $Path.set_curve(curve)
    $Path/PathFollow2D.unit_offset = 0
    $Path.show()
