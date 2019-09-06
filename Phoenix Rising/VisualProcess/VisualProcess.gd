extends Node2D

var starting_pos = null
var visual_inputs = []
var start_input = ''
var curve = Curve2D.new()

onready var ValueNode = get_node("Path/PathFollow2D/Value")

func _ready():
    $Path.hide()
    
func _on_InputOutput_start_input_position(pos):
    starting_pos = (Vector2(pos[0], pos[1]-50))
    start_input = "Oi"

func _on_RunEnvironment_visual_process_arguments(path_points, intermediate_inputs):
    visual_inputs = intermediate_inputs
    curve.clear_points()
    $Path.set_curve(curve)
    var curve_points = []
    curve_points.append(starting_pos)
    
    for point in path_points:
       curve_points.append(Vector2(point[0], point[1]))
    
    for point in curve_points:
        point[1] += 50
        curve.add_point(point)

func _on_MovableActionSpace_change_area_entered(action_number):
    ValueNode.text = str(visual_inputs[action_number - 1])

func _on_RunEnvironment_set_curve():
    $Path.show()
    $Path.set_curve(curve)
    
func _on_InputOutput_start_input_visual_entered():
    ValueNode.text = start_input
