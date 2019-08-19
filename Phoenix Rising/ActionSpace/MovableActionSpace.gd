extends Node2D

signal entered_tree(node_name)

var mouse_in = false
onready var HandSprite = get_node("ClickDragArea/OpenCloseHand")

#The default path of the textures
const DEFAULT_PATH = "res://Acessorios/art/"
#Variables that holds the current connection on the Movable
#Action Space
var current_input = 0
var current_output = 0
#Total number of diferent connections on one side (input OR output)
var num_connections = 2
#The input connection nodes
onready var input_connections = [$InputArea/DefaultConnection, $InputArea/ZConnection]
#The output connection nodes
onready var output_connections = [$OutputArea/DefaultConnection, $OutputArea/ZConnection]
#The input collision nodes
onready var input_collisions = [$InputArea/DefaultInputCollisionShape, $InputArea/ZInputCollisionShape]
#The output collision nodes
onready var output_collisions = [$OutputArea/DefaultOutputCollisionShape, $OutputArea/ZOutputCollisionShape]
#The connected textures paths
onready var connected_textures = [DEFAULT_PATH + "input_output_with_connection.png", 
                                 DEFAULT_PATH + "z_output_with_connection.png"]
#The not connected texture paths                               
onready var not_connected_textures = [DEFAULT_PATH + "input_output_no_connection.png", 
                                     DEFAULT_PATH + "z_output_no_connection.png"]

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
    #Changes the texture to the connected (green one)
    input_connections[current_input].texture = load(connected_textures[current_input])
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
    input_connections[current_input].texture = load(not_connected_textures[current_input])
    $ActionNumber.text = "0"

func _on_OutputArea_area_shape_entered(area_id, area, area_shape, self_shape):
    output_connections[current_output].texture = load(connected_textures[current_output])

func _on_OutputArea_area_shape_exited(area_id, area, area_shape, self_shape):
    output_connections[current_output].texture = load(not_connected_textures[current_output])

func _on_InputChangeButton_pressed():
    input_connections[current_input].hide()
    input_collisions[current_input].set_disabled(true)
    current_input = (current_input + 1) % num_connections
    input_connections[current_input].show()
    input_collisions[current_input].set_disabled(false)

func _on_OutputChangeButton_pressed():
    output_connections[current_output].hide()
    output_collisions[current_output].set_disabled(true)
    current_output = (current_output + 1) % num_connections
    output_connections[current_output].show()
    output_collisions[current_output].set_disabled(false)
