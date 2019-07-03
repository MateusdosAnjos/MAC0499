extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _on_Run_pressed():
    var items = []
    var actionsPath = []
    var regex = RegEx.new()
    regex.compile("ActionSpace*")
    var inventoryNode = (self.owner).get_node('Inventory')
    for node in inventoryNode.get_children():
        if regex.search(node.get_name()) and node.placedItem:
            items.append(node.placedItem.get_meta("id"))        
    for item in items:
        actionsPath.append(ItemDB.get_item(item)["codePath"])    
    for action in actionsPath:
        var godotScript = load(action)
        godotScript.new("agora imprime argumento")
    