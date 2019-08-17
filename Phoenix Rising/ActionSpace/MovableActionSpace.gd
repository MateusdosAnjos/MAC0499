extends Node2D

signal entered_tree(node_name)

var mouseIn = false
onready var HandSprite = get_node("ClickDragArea/OpenCloseHand")

func _ready():
    emit_signal("entered_tree", get_name())
    
func _process(delta):
    #Created new input, same as 'inv_grab' for easier understanding
    #of the code
    if(mouseIn && Input.is_action_pressed("mouse_click")):
        click_and_drag()
    pass

func click_and_drag():
    if not $ActionSpace.placed_item:
        HandSprite.stop()
        HandSprite.set_frame(1)
        set_position(get_viewport().get_mouse_position())   

func _on_Area2D_mouse_entered():
    HandSprite.play("open_close_hand")
    mouseIn = true

func _on_Area2D_mouse_exited():
    HandSprite.stop()
    HandSprite.set_frame(0)
    mouseIn = false



func _on_InputArea_area_shape_entered(area_id, area, area_shape, self_shape):
    print("Opa Input")


func _on_OutputArea_area_shape_entered(area_id, area, area_shape, self_shape):
    print("Opa Output")
