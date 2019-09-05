extends Node2D

var starting_pos = null

func _ready():
    $Path.hide()
    
func _on_InputOutput_start_input_position(pos):
    starting_pos = (Vector2(pos[0], pos[1]-50))

func _on_RunEnvironment_visual_process_path_points(path_points):
    var curve_points = []
    curve_points.append(starting_pos)
    
    for point in path_points:
       curve_points.append(Vector2(point[0], point[1]))
    
    var curve = Curve2D.new()
    for point in curve_points:
        point[1] += 50
        curve.add_point(point)
        
    $Path.set_curve(curve)
    $Path.show()

func _on_MovableActionSpace_change_area_entered():
    print("VAMO")
