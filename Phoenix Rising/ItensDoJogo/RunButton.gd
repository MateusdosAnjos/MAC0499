extends Button

var input
var output

onready var InventoryNode = (self.owner).get_node('Inventory')

func _ready():
    pass

func create_regex(regex_string):
    var regex = RegEx.new()
    regex.compile(str(regex_string))
    return regex

#This function sorts the Movable Action Spaces on the scene tree
#using the Action Number as comparision. The smaller the number
#higher on the tree it will be.
#ActionSpaces that are not connected to the source (action number == 0)
#don't need to be promoted in the tree
func _sort_MovableActionSpaces():
    var regex = create_regex("MovableActionSpace*")
    for node in InventoryNode.get_children():
        if regex.search(node.get_name()) and node.get_node("ActionNumber").text != "0":
            InventoryNode.move_child(node, int(node.get_node("ActionNumber").text))
    return

#Gets the ActionSpaces list following the tree order.
#node_list will maintain the ActionNumber order, because the
#ActionSpaces are ordered in the tree.
func _get_ActionSpaces_node_list(node_list):
    var regex = create_regex("MovableActionSpace*")    
    for node in InventoryNode.get_children():
        if regex.search(node.get_name()) and node.get_node("ActionSpace").placed_item:
            if node.get_node("ActionNumber").text != "0":
                node_list.append(node.get_node("ActionSpace"))           
    return
            
func _get_ActionSpaces_item_list(item_list, node_list):
    for node in node_list:
        if node.placed_item != null:
            item_list.append(node.placed_item.get_meta("id"))
    return            

func _get_items_code_path(items, code_paths):
    for item in items:
        code_paths.append(ItemDB.get_item(item)["codePath"])

func _get_items_arguments(node_list, arguments_list):
    for item in node_list:
        arguments_list.append(item.argument_list)        

func _process_input(input, code_paths, arguments_list):
    var processed_input = input
    var player_answer = []
    var arguments = null
    var i = 0
    for item_code in code_paths:
        var input_process_code = load(item_code)
        var code_node = input_process_code.new()
        arguments = arguments_list[i]
        i = i + 1
        processed_input = code_node.execute(processed_input, arguments, player_answer)
    return player_answer                 

func _set_answer_on_screen(answer):
    var PlayerOutput = get_parent().get_node("InputOutput/OutputBase/PlayerOutput")
    PlayerOutput.text = answer
    return
    
func _on_Run_pressed():
    var node_list = []
    var item_list = []
    var code_paths = []
    var arguments_list = []
    _sort_MovableActionSpaces()
    _get_ActionSpaces_node_list(node_list)
    _get_ActionSpaces_item_list(item_list, node_list)  
    _get_items_code_path(item_list, code_paths)
    _get_items_arguments(node_list, arguments_list)
    var answer_list = _process_input(input, code_paths, arguments_list)
    var answer_string = PoolStringArray(answer_list).join(" ")
    _set_answer_on_screen(answer_string)
    if (answer_string == output):
        print("Parabéns voce conseguiu!")
    else:
        print("Ops, algo está errado!")     
    
func _on_Tutorial_input_output_defined(inp, out):
    input = inp
    output = out
    var ExpectedOutput = get_parent().get_node("InputOutput/OutputBase/ExpectedOutput")
    ExpectedOutput.text = output  
    