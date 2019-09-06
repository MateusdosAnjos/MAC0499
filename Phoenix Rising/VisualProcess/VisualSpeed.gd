extends MenuButton

onready var ValueNode = get_parent().get_node("Path/PathFollow2D/Value")

func _ready():
    self.get_popup().add_item("1x")
    self.get_popup().add_item("2x")
    self.get_popup().add_item("4x")
    self.get_popup().add_item("8x")
    
    self.get_popup().connect("id_pressed", self, "_on_speed_selected")

func _on_speed_selected(id):
    var speed_modifier = self.get_popup().get_item_text(id)
    print(ValueNode.speed)
    
