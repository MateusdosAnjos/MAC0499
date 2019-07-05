extends Button

var input
var output

func _ready():
    pass
    
func _on_Run_pressed():
    var items = []
    var actionsPath = []
    var regex = RegEx.new()
    regex.compile("ActionSpace*")
    var inventoryNode = (self.owner).get_node('Inventory')
    for node in inventoryNode.get_children():
        if regex.search(node.get_name()) and node.placed_item:
            items.append(node.placed_item.get_meta("id"))        
    for item in items:
        actionsPath.append(ItemDB.get_item(item)["codePath"])    
    for action in actionsPath:
        var godotScript = load(action)
        godotScript.new("agora imprime argumento")
    if (input == output):
        print("Parabéns voce conseguiu!")  
    
func _on_Tutorial_input_output_defined(inp, out):
    input = inp
    output = out