extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func new_game():
    $Phoenix.start($StartPosition.position)
    $HUD.show_message("Prepare-se!")

func _on_HUD_start_game():
    new_game()

func _on_Help_mouse_entered():
    print("Oe")
