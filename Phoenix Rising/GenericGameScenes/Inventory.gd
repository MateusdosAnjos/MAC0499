extends Control

#Used to signal when the player asks for an item help
signal inv_help

#Used to load the base scene of an item
const item_base = preload("res://GenericGameScenes/ItemBase.tscn")

#Variables that handles the Inventory Items and Containers
onready var grid = $Grid
var containers = [null]
var item_held = null
var item_offset = Vector2()
var last_container = null
var last_pos = Vector2()

#Variables that handles the enumeration of Actions
#and if the system is ready to run
var all_conected = false
var movable_action_nodes = []

#Used to initialize the inventory items
func _ready():
    pickup_item("soma")
    pickup_item("subtracao")
    pickup_item("multi")
    pickup_item("print")
    pickup_item("print")
    pickup_item("print")
    pickup_item("if/else")    
    containers[0] = grid

func _process(delta):
    var cursor_pos = get_global_mouse_position()
    if Input.is_action_just_pressed("inv_help"):
        emit_signal("inv_help", cursor_pos)
    if Input.is_action_just_pressed("inv_grab"):
        grab(cursor_pos)
    if Input.is_action_just_released("inv_grab"):
        release(cursor_pos)
    if item_held != null:
        item_held.rect_global_position = cursor_pos + item_offset

#Grabs the item under the cursor position (cursor_pos), allowing
#to move it on screen       
func grab(cursor_pos):
    var c = get_container_under_cursor(cursor_pos)
    if c != null and c.has_method("grab_item"):
        item_held = c.grab_item(cursor_pos)
        if item_held != null:
            last_container = c
            last_pos = item_held.rect_global_position
            item_offset = item_held.rect_global_position - cursor_pos
            move_child(item_held, get_child_count())

#Releases the item in the container under the cursor position (cursor_pos)
#returns the item to the last position if there is no container under
#the cursor                        
func release(cursor_pos):
    if item_held == null:
        return
    var c = get_container_under_cursor(cursor_pos)
    if c == null:
        return_item()
    elif c.has_method("insert_item"):
        if c.insert_item(item_held):
            item_held = null
        else:
            return_item()
    else:
        return_item()                
 
#Returns which container is under the cursor, if
#there is no container under it returns null                         
func get_container_under_cursor(cursor_pos):
    for c in containers:
        if c.get_global_rect().has_point(cursor_pos):
            return c
    return null

#Throws the item away
func drop_item():
    item_held.queue_free()
    item_held = null 

#Returns the item to it's last position
func return_item():
    item_held.rect_global_position = last_pos
    last_container.insert_item(item_held)
    item_held = null  

#Loads the item from ItemDB and place it on inventory grid
#Return true when sucessful and false when it's not
func pickup_item(item_id):
    var item = item_base.instance()
    item.set_meta("id", item_id)
    item.texture = load(ItemDB.get_item(item_id)["icon"])
    add_child(item)
    if !grid.insert_item_at_first_available_spot(item):
        item.queue_free()
        return false
    return true                                  

#This function searches for the movable and fixed ActionSpaces,
#appending the fixed one on the containers list and the movable
#on the movable_action_nodes list
func _on_MovableActionSpace_entered_tree(node_name):
    var movable_node_name = get_node(node_name)
    containers.append(movable_node_name.get_node("ActionSpace"))
    movable_action_nodes.append(movable_node_name)

#This functions handles the signals of the endpoints connections
#Sets the Action Number of the Movable Action Space conected to
#the source to 1
func _on_InputOutput_start_input_entered(area):
    area.get_parent().get_node("ActionNumber").text = "1"

#Sets '0' for all Movable Action Spaces once the source
#is not conected
func _on_InputOutput_start_input_exited():
    for node in movable_action_nodes:
        node.get_node("ActionNumber").text = "0"  

#Sets 'all_conected' to true when the system conects the input source
#to the players output using Movables Action Spaces.
#Remember: The ActionNumber text of an MovableActionSpace is not 0
#when he is somehow conected to the input source
func _on_InputOutput_finish_input_entered(area):
    if area.get_parent().get_node("ActionNumber").text != "0":
        all_conected = true
    
#If don't reach the endline it's not conected    
func _on_InputOutput_finish_input_exited():
    all_conected = false
    