extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _on_Run_pressed():
    var actions = []
    var regex = RegEx.new()
    regex.compile("ActionSpace*")
    var inventoryNode = (self.owner).get_node('Invertory')
    for node in inventoryNode.get_children():
        if regex.search(node.get_name()):
            actions.append(node)
            print(node.items)
