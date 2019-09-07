extends MenuButton

onready var ValueNode = get_parent().get_node("Path/PathFollow2D/Value")

#Creates the items on popup
func _ready():
    self.get_popup().add_item("1x")
    self.get_popup().add_item("2x")
    self.get_popup().add_item("4x")
    self.get_popup().add_item("8x")
    
    self.get_popup().connect("id_pressed", self, "_on_speed_selected")

#Receives the id of given speed and calls the respective function
#that handles it
func _on_speed_selected(id):
    var speed_modifier = self.get_popup().get_item_text(id)
    match speed_modifier:
        '1x':
            _1x_speed()
        '2x':
            _2x_speed()
        '4x':
            _4x_speed()
        '8x':
            _8x_speed()
            
################################################################################
#       Changes the speed and the button text to the respective speed          #
################################################################################
func _1x_speed():
    ValueNode.speed = 80
    self.text = "Velocidade da Animação: 1x"
func _2x_speed():
    ValueNode.speed = 160
    self.text = "Velocidade da Animação: 2x"
func _4x_speed():
    ValueNode.speed = 320
    self.text = "Velocidade da Animação: 4x"
func _8x_speed():
    ValueNode.speed = 640
    self.text = "Velocidade da Animação: 8x"
    