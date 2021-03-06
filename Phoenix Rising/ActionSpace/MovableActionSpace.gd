extends Node2D

signal entered_tree(node_name)
signal change_area_entered()

var mouse_in = false
onready var HandSprite = get_node("ClickDragArea/OpenCloseHand")

#The default path of the textures
const DEFAULT_PATH = "res://Accessories/art/"

#Variables that holds the current connection on the Movable
#Action Space
var current_input = 0
var current_output = 0

#Total number of diferent connections for each side
var num_input_connections = 5
var num_output_connections = 5

#The input connection nodes
onready var input_connections = [$InputArea/DefaultConnection, $InputArea/ZConnection, $InputArea/LongConnection,
                                 $ConvergeArea/ConvergeConnection, $InputArea/SConnection]
#The output connection nodes
onready var output_connections = [$OutputArea/DefaultConnection, $OutputArea/ZConnection, $OutputArea/LongConnection,
                                  $IfArea/IfConnection, $OutputArea/SConnection]
#The input collision nodes
onready var input_collisions = [[$InputArea/DefaultInputCollisionShape], [$InputArea/ZInputCollisionShape],
                                [$InputArea/LongCollisionShape], [$ConvergeArea/IfConvergeCollisionShape, $ConvergeArea/ElseConverge/ElseConvergeCollisionShape], [$InputArea/SCollisionShape]]

#The output collision nodes
onready var output_collisions = [[$OutputArea/DefaultOutputCollisionShape], [$OutputArea/ZOutputCollisionShape], 
                                 [$OutputArea/LongCollisionShape], [$IfArea/IfCollisionShape, $IfArea/ElseArea/ElseCollisionShape], [$OutputArea/SCollisionShape]]

#The connected textures paths
onready var input_connected_textures = [DEFAULT_PATH + "default_with_connection.png", 
                                        DEFAULT_PATH + "z_with_connection.png",
                                        DEFAULT_PATH + "long_with_connection.png",
                                        DEFAULT_PATH + "converge_with_connection.png",
                                        DEFAULT_PATH + "z_with_connection.png"]
                                
onready var output_connected_textures = [DEFAULT_PATH + "default_with_connection.png", 
                                        DEFAULT_PATH + "z_with_connection.png",
                                        DEFAULT_PATH + "long_with_connection.png",
                                        DEFAULT_PATH + "if_else_with_connection.png",
                                        DEFAULT_PATH + "z_with_connection.png"]

#The not connected texture paths                               
onready var input_not_connected_textures = [DEFAULT_PATH + "default_no_connection.png", 
                                            DEFAULT_PATH + "z_no_connection.png",
                                            DEFAULT_PATH + "long_no_connection.png",
                                            DEFAULT_PATH + "converge_no_connection.png",
                                            DEFAULT_PATH + "z_no_connection.png"]
                                            
onready var output_not_connected_textures = [DEFAULT_PATH + "default_no_connection.png", 
                                             DEFAULT_PATH + "z_no_connection.png",
                                             DEFAULT_PATH + "long_no_connection.png",
                                             DEFAULT_PATH + "if_else_no_connection.png",
                                             DEFAULT_PATH + "z_no_connection.png"]

#Handles if both if and else paths are connected to the converge connection
onready var converge_if_connected = false
onready var converge_else_connected = false

#Handles if both if and else path have a connection
onready var if_connected = false
onready var else_connected = false

#Used to create the Movable Action Space execution tree (see RunEnvironment.gd)
onready var right_child = null
onready var left_child = null

#Used to create the need of two paths when using if/else command
onready var DummyNode = Node2D.new()

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
    for collision_list in input_collisions:
        for collision in collision_list:
            collision.set_disabled(true)
    for collision_list in output_collisions:
        for collision in collision_list:
             collision.set_disabled(true)
    input_collisions[0][0].set_disabled(false)
    output_collisions[0][0].set_disabled(false)
                 
func _ready():
    emit_signal("entered_tree", get_name())
    _hide_connections()
    _disable_collisions()
    DummyNode.name = "DummyNode"
    
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
        self.z_index = 1

func _on_Area2D_mouse_entered():
    HandSprite.play("open_close_hand")
    mouse_in = true

func _on_Area2D_mouse_exited():
    HandSprite.stop()
    HandSprite.set_frame(0)
    mouse_in = false
    self.z_index = 0

func _enumerate_action(area):
    #StartInputArea is the action with number 0 and has no atribute "text" 
    if area.name != "StartInputArea":
        #'area' holds the area2D of the MovableActionSpace that is fixed (not
        #from the one we are moving in the game).
        #First gets the parent of 'area', then gets the "ActionNumber" node
        #and acess the 'text' field(the action number), transforming the string
        #into an int to perform operations
        area = area.get_parent()
        while (not ("MovableActionSpace" in area.name)):
            area = area.get_parent()
        var action_number = int(area.get_node("ActionNumber").text)
        #Checks if the previous action is somehow conected with the Input because 
        #only makes sense to enumerate when the system is conected with input
        #source
        if action_number != 0:
            #Increase the action number by 1 (that's why is the 'next'). Now we have
            #the action number of the node we are moving in the game
            var next_action_number = action_number + 1
            #Place the correct number for the moving ActionSpace in game
            $ActionNumber.text = str(next_action_number)

###################################################################################################
#                                        INPUT CONNECTIONS                                        #
###################################################################################################
#Changes the texture to the connected (green one) and enumerate the movable action space
func _on_InputArea_area_shape_entered(area_id, area, area_shape, self_shape):
    input_connections[current_input].texture = load(input_connected_textures[current_input])
    _enumerate_action(area)

func _on_InputArea_area_shape_exited(area_id, area, area_shape, self_shape):
    input_connections[current_input].texture = load(input_not_connected_textures[current_input])
    $ActionNumber.text = "0"

func _on_ConvergeArea_area_shape_entered(area_id, area, area_shape, self_shape):
    converge_if_connected = true
    if converge_if_connected or converge_else_connected:
        input_connections[current_input].texture = load(input_connected_textures[current_input])
    _enumerate_action(area)
    
func _on_ConvergeArea_area_shape_exited(area_id, area, area_shape, self_shape):
    converge_if_connected = false
    input_connections[current_input].texture = load(input_not_connected_textures[current_input])

func _on_ElseConverge_area_shape_entered(area_id, area, area_shape, self_shape):
    converge_else_connected = true
    if converge_if_connected or converge_else_connected:
        input_connections[current_input].texture = load(input_connected_textures[current_input])

func _on_ElseConverge_area_shape_exited(area_id, area, area_shape, self_shape):
    converge_else_connected = false
    input_connections[current_input].texture = load(input_not_connected_textures[current_input])

###################################################################################################
#                                       OUTPUT CONNECTIONS                                        #
###################################################################################################
func _on_OutputArea_area_shape_entered(area_id, area, area_shape, self_shape):
    output_connections[current_output].texture = load(output_connected_textures[current_output])
    area = area.get_parent()
    if (area.name == "InputOutput"):
        right_child = area
    else:
        while (not ("MovableActionSpace" in area.name)):
            area = area.get_parent()
        right_child = area

func _on_OutputArea_area_shape_exited(area_id, area, area_shape, self_shape):
    output_connections[current_output].texture = load(output_not_connected_textures[current_output])
    right_child = null

func _on_IfArea_area_shape_entered(area_id, area, area_shape, self_shape):
    if_connected = true
    if else_connected:
        output_connections[current_output].texture = load(output_connected_textures[current_output])
    area = area.get_parent()
    if (area.name == "InputOutput"):
        right_child = area
    else:
        while (not ("MovableActionSpace" in area.name)):
            area = area.get_parent()
        right_child = area
    if (left_child == null):
        left_child = DummyNode
    
func _on_IfArea_area_shape_exited(area_id, area, area_shape, self_shape):
    if_connected = false
    output_connections[current_output].texture = load(output_not_connected_textures[current_output])
    right_child = null

func _on_ElseArea_area_shape_entered(area_id, area, area_shape, self_shape):
    else_connected = true
    if if_connected:
        output_connections[current_output].texture = load(output_connected_textures[current_output])
    area = area.get_parent()
    if (area.name == "InputOutput"):
        left_child = area
    else:
        while (not ("MovableActionSpace" in area.name)):
            area = area.get_parent()
        left_child = area
    if (right_child == null):
        right_child = DummyNode
    
func _on_ElseArea_area_shape_exited(area_id, area, area_shape, self_shape): 
    else_connected = false  
    output_connections[current_output].texture = load(output_not_connected_textures[current_output])
    left_child = null 

###################################################################################################
#                                        CHANGING CONNECTIONS                                     #
###################################################################################################   
func _on_InputChangeButton_pressed():
    input_connections[current_input].hide()
    for collisions in input_collisions[current_input]: 
        collisions.set_disabled(true)
    input_connections[current_input].texture = load(input_not_connected_textures[current_input])
    current_input = (current_input + 1) % num_input_connections
    input_connections[current_input].show()
    for collisions in input_collisions[current_input]: 
        collisions.set_disabled(false)

func _on_OutputChangeButton_pressed():
    output_connections[current_output].hide()
    for collisions in output_collisions[current_output]: 
        collisions.set_disabled(true)
    output_connections[current_output].texture = load(output_not_connected_textures[current_output])
    current_output = (current_output + 1) % num_output_connections
    output_connections[current_output].show()
    for collisions in output_collisions[current_output]: 
        collisions.set_disabled(false)
    right_child = null
    left_child = null

###################################################################################################
#                                SIGNAL FOR VISUAL CHANGES                                        #
###################################################################################################  
func _on_ChangeArea_area_entered(area):
    if ($ActionSpace.placed_item):
        emit_signal("change_area_entered")
