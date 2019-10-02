extends Node2D

#Signal to control yield call on _process_input (RunEnvironment.gd)
signal end_path()

var starting_pos = null
var finish_pos = null
var visual_inputs = []
var start_input = ''
var curve = Curve2D.new()
var next_value = 0
var total_inputs = 0
var current_start_input = 0
var total_visuals = 0

onready var ValueNode = get_node("Path/PathFollow2D/Value")

func _ready():
    $Path.hide()

#Sets the first point of the path  
func _on_InputOutput_start_input_position(pos):
    starting_pos = (Vector2(pos[0], pos[1]-50))
    start_input = get_parent().INPUT
    total_inputs = len(start_input)
    
#Sets the last point of the path  
func _on_InputOutput_output_position(pos):
    finish_pos = (Vector2(pos[0]+50, pos[1]))

#Creates the curve, using the positions of the action spaces,
#that visual process will follow (the offsets are used to make it better to view)
func _on_RunEnvironment_visual_process_arguments(path_points, intermediate_inputs):
    visual_inputs = intermediate_inputs
    total_visuals = len(visual_inputs)
    curve.clear_points()
    $Path.set_curve(curve)
    var curve_points = []
    curve_points.append(starting_pos)
    
    for point in path_points:
       curve_points.append(Vector2(point[0], point[1]))
        
    for point in curve_points:
        point[0] -= 50
        point[1] += 50
        curve.add_point(point)
    curve.add_point(finish_pos)
    $Path.set_curve(curve)
    $Path/PathFollow2D.set_unit_offset(0)
    $Path.show()
      
#Changes the text on Value, based on the output of the given
#Action space
func _on_MovableActionSpace_change_area_entered():
    ValueNode.text = str(visual_inputs[next_value])
    next_value = (next_value + 1) % total_visuals
    
#Sets the start value of the process
func _on_InputOutput_start_input_visual_entered():
    ValueNode.text = str(start_input[current_start_input])
    current_start_input = (current_start_input + 1) % total_inputs

#Called when the visual reaches the end of the path (Output arrow)
func _on_InputOutput_output_visual_entered():
    $Path.hide()
    $Path/PathFollow2D.set_unit_offset(0)
    emit_signal("end_path")
    