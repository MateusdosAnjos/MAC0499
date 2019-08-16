extends Node2D

var mouseIn = false
onready var HandSprite = get_node("Area2D/OpenCloseHand")

func _process(delta):
    # You need to create a action caleld "click"(Left mouse click) in the project input map.
    # Você precisa criar uma ação chamada click(botão esquerdo do mouse) no input map do seu projeto
    if(mouseIn && Input.is_action_pressed("inv_grab")):
        HandSprite.stop()
        HandSprite.set_frame(1)
        set_position(get_viewport().get_mouse_position())
    pass

func _on_Area2D_mouse_entered():
    HandSprite.play("open_close_hand")
    mouseIn = true

func _on_Area2D_mouse_exited():
    HandSprite.stop()
    HandSprite.set_frame(0)
    mouseIn = false
