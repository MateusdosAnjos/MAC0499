extends Sprite

onready var texture1 = preload("res://Acessorios/art/icon.png")
onready var texture2 = preload("res://Acessorios/art/PhoenixLogo.png")

var i = 0

func _ready():
    set_physics_process(true)

func _physics_process(delta):
    get_parent().set_offset(get_parent().get_offset() + (500*delta))
    

func _on_Timer_timeout():
    if i%2 == 0:
        self.texture = texture1
    else:
        self.texture = texture2
    i += 1        
