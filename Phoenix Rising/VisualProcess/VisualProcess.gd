extends Node2D

#Signal to control yield call on _process_input (RunEnvironment.gd)
signal end_path()

var starting_pos = null
var finish_pos = null
var start_input = ''
var curve = Curve2D.new()
var total_inputs = 0
var current_start_input = 0
var processed_input = null
var CurrentActionNode = null

var is_exit_sucess = false

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
    finish_pos = (Vector2(pos[0]+100, pos[1]-50))

#Creates the curve that visual process will follow, using the positions of the
#input and the first node of the function tree (the offsets are used to make it
#better to view)
func _on_RunEnvironment_visual_process_arguments(input, function_tree):
    processed_input = [input, true]
    CurrentActionNode = function_tree
    ValueNode.text = str(input)
    curve.clear_points()
    $Path.set_curve(curve)
    var curve_points = []
    curve_points.append(starting_pos)
    if (function_tree != null):
        curve_points.append((function_tree.node).global_position)
    else:
        curve_points.append(finish_pos)
    for point in curve_points:
        _add_next_point(point)
    _set_curve_to_path(curve, get_node("Path"))
    (get_node("Path")).show()

func _add_next_point(point):
    point[0] -= 20
    point[1] += 50
    curve.add_point(point)

func _set_curve_to_path(curve, PathNode):
    PathNode.set_curve(curve)
    (PathNode.get_node("PathFollow2D")).set_unit_offset(0)
    
#Executes the function of the current Action Node and sets the returned value to the
#visual shown on screen.
func _on_MovableActionSpace_change_area_entered():
    processed_input = (CurrentActionNode.function).call_func(processed_input[0], CurrentActionNode.arguments, CurrentActionNode.action_number)
    if (processed_input[0] == null):
        is_exit_sucess = false
        _clear_all_process()
        emit_signal("end_path")
    else:
        if (processed_input[1] == true):
            CurrentActionNode = CurrentActionNode.right_child
        else:
            CurrentActionNode = CurrentActionNode.left_child
        if (CurrentActionNode == null):
            _add_next_point(finish_pos)
        else:
            _add_next_point((CurrentActionNode.node).global_position)
    ValueNode.text = str(processed_input[0])
    
#Sets the start value of the process
func _on_InputOutput_start_input_visual_entered():
    ValueNode.text = str(start_input[current_start_input])
    current_start_input = (current_start_input + 1) % total_inputs

#Called when the visual reaches the end of the path (Output arrow)
func _on_InputOutput_output_visual_entered():
    curve = Curve2D.new()
    $Path.set_curve(curve)
    $Path.hide()
    is_exit_sucess = true
    emit_signal("end_path")

func _clear_all_process():
    curve = Curve2D.new()
    $Path.set_curve(curve)
    $Path.hide()
    current_start_input = 0
    ValueNode.text = str(" ")