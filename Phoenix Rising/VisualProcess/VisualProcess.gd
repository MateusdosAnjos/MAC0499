extends Node2D

var curve_points = []

func _on_InputOutput_start_input_position(pos):
    curve_points.append(Vector2(pos[0], pos[1]))

func _create_curve():
    var curve = Curve2D.new()
    for point in curve_points:
        curve.add_point(point)
    $Path.set_curve(curve)

func _on_RunEnvironment_process_points(points):
    for point in points:
       points.append(Vector2(point[0], point[1]))
