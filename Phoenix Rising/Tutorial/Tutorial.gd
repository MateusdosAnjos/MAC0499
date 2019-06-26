extends Node

func _ready():
    pass # Replace with function body.

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen
    
func _on_Nivel_1_pressed():
    get_tree().change_scene("res://Nivel1/Nivel1.tscn")

func _on_Run_pressed():
    var regex = RegEx.new()
    regex.compile("ActionSpace*")
    var inventoryNode = get_node("Invertory")
    for node in inventoryNode.get_children():
        if regex.search(node.get_name()):
            print(node.get_name())
