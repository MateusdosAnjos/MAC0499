extends Node2D

func _ready():
    var curve = Curve2D.new()
    curve.add_point(Vector2(120, 70))
    curve.add_point(Vector2(280, 140))
    curve.add_point(Vector2(480, 20))
    print(curve.get_point_count())
    $Path2D.set_curve(curve)