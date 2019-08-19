extends Node2D

signal entered_tree(node_name)

var mouse_in = false

onready var HandSprite = get_node("ClickDragArea/OpenCloseHand")

onready var connected_texture = preload("res://Acessorios/art/input_output_with_connection.png")
onready var not_connected_texture = preload("res://Acessorios/art/input_output_no_connection.png")
onready var z_connected_texture = preload("res://Acessorios/art/z_output_with_connection.png")
onready var z_not_connected_texture = preload("res://Acessorios/art/z_output_no_connection.png")

var current_input_connection = 0
var current_output_connection = 0
onready var input_connections = [$InputArea/DefaultConnection, $InputArea/ZConnection]
onready var output_connections = [$OutputArea/DefaultConnection, $OutputArea/ZConnection]
onready var input_collisions = [$InputArea/DefaultInputCollisionShape, $InputArea/ZInputCollisionShape]
onready var output_collisions = [$OutputArea/DefaultOutputCollisionShape, $OutputArea/ZOutputCollisionShape]

#Hides all but the default connection on the Movable Action Space
func _hide_connections():
    for connection in input_connections:
        connection.hide()
    for connection in output_connections:
        connection.hide()   
    input_connections[0].show()
    output_connections[0].show()

#Disables all but the default collision on the Movable Action Space  
func _disable_collisions():
    for collision in input_collisions:
         collision.set_disabled(true)
    for collision in output_collisions:
         collision.set_disabled(true)
    input_collisions[0].set_disabled(false)
    output_collisions[0].set_disabled(false)
                 
func _ready():
    emit_signal("entered_tree", get_name())
    _hide_connections()
    _disable_collisions()
    
func _process(delta):
    #Created new input, same as 'inv_grab' for easier understanding
    #of the code
    if(mouse_in && Input.is_action_pressed("mouse_click")):
        click_and_drag()
    pass

func click_and_drag():
    if not $ActionSpace.placed_item:
        HandSprite.stop()
        HandSprite.set_frame(1)
        set_position(get_viewport().get_mouse_position())   

func _on_Area2D_mouse_entered():
    HandSprite.play("open_close_hand")
    mouse_in = true

func _on_Area2D_mouse_exited():
    HandSprite.stop()
    HandSprite.set_frame(0)
    mouse_in = false

func _on_InputArea_area_shape_entered(area_id, area, area_shape, self_shape):
    #Changes the texture to the green one
    $InputArea/DefaultConnection.texture = connected_texture
    $InputArea/ZConnection.texture = z_connected_texture
    #StartInputArea is the action with number 0 and has no atribute "text" 
    if area.name != "StartInputArea":
        #'area' holds the area2D of the MovableActionSpace that is fixed (not
        #from the one we are moving in the game).
        #First gets the parent of 'area', then gets the "ActionNumber" node
        #and acess the 'text' field(the action number), transforming the string
        #into an int to perform operations
        var action_number = int(area.get_parent().get_node("ActionNumber").text)
        #Checks if the previous action is somehow conected with the Input because 
        #only makes sense to enumerate when the system is conected with input
        #source
        if action_number != 0:
            #Increase the action number by 1 (that's why is the 'next'). Now we have
            #the action number of the node we are moving in the game
            var next_action_number = action_number + 1
            #Place the correct number for the moving ActionSpace in game
            $ActionNumber.text = str(next_action_number)

func _on_InputArea_area_shape_exited(area_id, area, area_shape, self_shape):
    $InputArea/DefaultConnection.texture = not_connected_texture
    $InputArea/ZConnection.texture = z_not_connected_texture
    $ActionNumber.text = "0"

func _on_OutputArea_area_shape_entered(area_id, area, area_shape, self_shape):
    $OutputArea/DefaultConnection.texture = connected_texture
    $OutputArea/ZConnection.texture = z_connected_texture

func _on_OutputArea_area_shape_exited(area_id, area, area_shape, self_shape):
    $OutputArea/DefaultConnection.texture = not_connected_texture
    $OutputArea/ZConnection.texture = z_not_connected_texture


func _on_OutputChangeButton_pressed():
    if $OutputArea/DefaultConnection.is_visible_in_tree():
        $OutputArea/DefaultConnection.hide()
        $OutputArea/DefaultOutputCollisionShape.set_disabled(true)    
        $OutputArea/ZConnection.show()
        $OutputArea/ZOutputCollisionShape.set_disabled(false)
        
    else:
        $OutputArea/DefaultConnection.show()
        $OutputArea/DefaultOutputCollisionShape.set_disabled(false)    
        $OutputArea/ZConnection.hide()
        $OutputArea/ZOutputCollisionShape.set_disabled(true)


func _on_InputChangeButton_pressed():
    if $InputArea/DefaultConnection.is_visible_in_tree():
        $InputArea/DefaultConnection.hide()
        $InputArea/DefaultInputCollisionShape.set_disabled(true)    
        $InputArea/ZConnection.show()
        $InputArea/ZInputCollisionShape.set_disabled(false)
        
    else:
        $InputArea/DefaultConnection.show()
        $InputArea/DefaultInputCollisionShape.set_disabled(false)    
        $InputArea/ZConnection.hide()
        $InputArea/ZInputCollisionShape.set_disabled(true)
