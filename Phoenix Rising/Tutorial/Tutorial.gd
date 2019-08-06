extends Node

signal input_output_defined(input, output)

const INPUT = 'Mensagem de teste'
const OUTPUT = 'Mensagem de teste'

func _ready():
    var input_text = get_node("InputOutput/InputBase/Input")
    input_text.newline()
    input_text.add_text(String(INPUT))
    emit_signal("input_output_defined", INPUT, OUTPUT)

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen
    
func _on_Nivel_1_pressed():
    get_tree().change_scene("res://Nivel1/Nivel1.tscn")            
