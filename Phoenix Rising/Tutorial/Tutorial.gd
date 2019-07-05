extends Node

const INPUT = 5
const OUTPUT = 5

func _ready():
    var inputText = get_node("InputOutput/InputBase/Input")
    inputText.newline()
    inputText.add_text(String(INPUT))

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen
    
func _on_Nivel_1_pressed():
    get_tree().change_scene("res://Nivel1/Nivel1.tscn")            
