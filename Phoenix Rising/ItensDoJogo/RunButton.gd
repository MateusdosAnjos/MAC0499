extends Button

var input
var output

func _ready():
    pass

func _get_ActionSpaces_node_list(node_list):
    var regex = RegEx.new()
    regex.compile("ActionSpace*")
    var inventoryNode = (self.owner).get_node('Inventory')
    for node in inventoryNode.get_children():
        if regex.search(node.get_name()) and node.placed_item:
            node_list.append(node)
    return
            
func _get_ActionSpaces_item_list(item_list, node_list):
    for node in node_list:
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
    