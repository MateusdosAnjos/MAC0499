extends RichTextLabel

var speed = 80

func _ready():
    set_physics_process(true)

#Makes the node follows the path using the given speed
func _physics_process(delta):
    get_parent().set_offset(get_parent().get_offset() + (speed*delta))