extends Button

var input
var output

func _ready():
    pass

func _get_ActionSpaces_item_list(list):
    var regex = RegEx.new()
    regex.compile("ActionSpace*")
    var inventoryNode = (self.owner).get_node('Inventory')
    for node in inventoryNode.get_children():
        if regex.search(node.get_name()) and node.placed_item:
            list.append(node.placed_item.get_meta("id"))
    return            

func _get_items_code_path(items, code_paths):
    for item in items:
        code_paths.append(ItemDB.get_item(item)["codePath"])

func _process_input(input, code_paths):
    var processed_input = input
    for item_code in code_paths:
        var input_process_code = load(item_code)
        var code_node = input_process_code.new()
        processed_input = code_node.execute(processed_input)      
    return processed_input                 
    
func _on_Run_pressed():
    var items = []
    var code_paths = []
    _get_ActionSpaces_item_list(items)  
    _get_items_code_path(items, code_paths)  
    if (_process_input(input, code_paths) == output):
        print("Parabéns voce conseguiu!")
    else:
        print("Ops, algo está errado!")     
    
func _on_Tutorial_input_output_defined(inp, out):
    input = inp
    output = out