extends Node2D

signal entered_tree(node_name)

var mouseIn = false
onready var HandSprite = get_node("ClickDragArea/OpenCloseHand")
onready var connected_texture = preload("res://Acessorios/art/input_output_with_connection.png")
onready var not_connected_texture = preload("res://Acessorios/art/input_output_no_connection.png")

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
    #Changes the texture to the green one
    $InputArea/Sprite.texture = connected_texture
    #StartInputArea is the action with number 0 and has no atribute "text" 
    if area.name != "StartInputArea":
        #'area' holds the area2D of the MovableActionSpace that is fixed (not
        #from the one we are moving in the game).
        #First gets the parent of 'area', then gets the "ActionNumber" node
        #and acess the 'text' field(the action number), transforming the string
        #into an int to perform operations
        var action_number = int(area.get_parent().get_node("ActionNumber").text)
        #Increase the action number by 1 (that's why is the 'next'). Now we have
        #the action number of the node we are moving in the game
        var next_action_number = action_number + 1
        #Place the correct number for the moving ActionSpace in game
        $ActionNumber.text = str(next_action_number)

func _on_InputArea_area_shape_exited(area_id, area, area_shape, self_shape):
    $InputArea/Sprite.texture = not_connected_texture

func _on_OutputArea_area_shape_entered(area_id, area, area_shape, self_shape):
    $OutputArea/Sprite.texture = connected_texture

func _on_OutputArea_area_shape_exited(area_id, area, area_shape, self_shape):
    $OutputArea/Sprite.texture = not_connected_texture
