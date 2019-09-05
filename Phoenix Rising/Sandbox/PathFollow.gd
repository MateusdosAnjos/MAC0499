extends Node2D

signal distances_set(distances)

func _ready():
    var curve = Curve2D.new()
    var distances = []
    var points = [Vector2(100, 120), Vector2(250, 200), Vector2(350, 280), Vector2(820, 610), Vector2(1115, 430)]
    _calculate_distance(points, distances)
    emit_signal("distances_set", distances)
    for point in points:
        curve.add_point(point)
    $Path2D.set_curve(curve)

func _calculate_distance(points, distance):
    for j in range (len(points)-1):
        distance.append(int(sqrt(((points[j][0] - points[j+1][0]) * (points[j][0] - points[j+1][0])) + ((points[j][1] - points[j+1][1]) * (points[j][1] - points[j+1][1])))))
    distance.append(1)
    print(distance)