extends Control

#Used to signal when the player asks for an item help
signal inv_help

#Used to load the base scene of an item
const item_base = preload("res://ItensDoJogo/ItemBase.tscn")

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
var ordered_action_nodes = []

func _ready():
    pickup_item("soma")
    pickup_item("subtracao")
    pickup_item("multi")
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
        

func grab(cursor_pos):
    var c = get_container_under_cursor(cursor_pos)
    if c != null and c.has_method("grab_item"):
        item_held = c.grab_item(cursor_pos)
        if item_held != null:
            last_container = c
            last_pos = item_held.rect_global_position
            item_offset = item_held.rect_global_position - cursor_pos
            move_child(item_held, get_child_count())
                        
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
                          
func get_container_under_cursor(cursor_pos):
    for c in containers:
        if c.get_global_rect().has_point(cursor_pos):
            return c
    return null

func drop_item():
    item_held.queue_free()
    item_held = null 

func return_item():
    item_held.rect_global_position = last_pos
    last_container.insert_item(item_held)
    item_held = null  

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
#on the ordered_action_nodes list
func _on_MovableActionSpace_entered_tree(node_name):
    var movable_node_name = get_node(node_name)
    containers.append(movable_node_name.get_node("ActionSpace"))
    ordered_action_nodes.append(movable_node_name)
    return

# This functions handles the signals of the endpoints connections
func _on_InputOutput_start_input_entered(area):
    #Sets the Action Number of the Movable Action Space conected to
    #the source to 1
    area.get_parent().get_node("ActionNumber").text = "1"
    pass

func _on_InputOutput_start_input_exited():
    #Sets '0' for all Movable Action Spaces once the source
    #is not conected
    for node in ordered_action_nodes:
        node.get_node("ActionNumber").text = "0"  
    pass

func _on_InputOutput_finish_input_entered(area):
    #Sets 'all_conected' to true when the system conects the input source
    #to the players output using Movables Action Spaces.
    #Remember: The ActionNumber text of an MovableActionSpace is not 0
    #when he is somehow conected to the input source
    if area.get_parent().get_node("ActionNumber").text != "0":
        all_conected = true
    pass
    
func _on_InputOutput_finish_input_exited():
    #If don't reach the endline it's not conected
    all_conected = false
    pass