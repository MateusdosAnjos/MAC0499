extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    $TimerInicio.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func new_game():
    $Phoenix.start($PosicaoInicial.position)

func _on_TimerInicio_timeout():
    new_game()
