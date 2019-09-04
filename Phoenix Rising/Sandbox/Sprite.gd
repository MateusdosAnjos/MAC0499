extends Label

var i = 0

func _ready():
    set_physics_process(true)

func _physics_process(delta):
    get_parent().set_offset(get_parent().get_offset() + (80*delta))   

func _on_Timer_timeout():
    self.text = str(i)
    i = i + 1
