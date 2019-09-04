extends Node2D

var curve_points = []

func _on_InputOutput_start_input_position(pos):
    curve_points.append(Vector2(pos[0], pos[1]))
    _create_curve()

func _create_curve():
    var curve = Curve2D.new()
    for point in curve_points:
        curve.add_point(point)
    curve.add_point(Vector2(120, 70))
    curve.add_point(Vector2(280, 140))
    curve.add_point(Vector2(480, 20))
    $Path.set_curve(curve)
