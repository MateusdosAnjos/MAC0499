extends Label

var i = 0
var speed = 80
var times = []

func _ready():
    set_physics_process(true)

func _physics_process(delta):
    get_parent().set_offset(get_parent().get_offset() + (speed*delta))   

func _on_Timer_timeout():
    self.text = str(i)
    get_parent().get_parent().get_parent().get_node("Timer").start(times[i])
    if (i == 4):
        get_parent().get_parent().get_parent().get_node("Timer").stop()
    i = i + 1

func _on_Node2D_distances_set(distances):
    for dist in distances:
        times.append(int(dist/speed))
    print(times)
