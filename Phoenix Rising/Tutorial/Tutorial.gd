extends Node

signal input_output_defined(input, output)

const INPUT = 'Mensagem de teste'
const OUTPUT = 'Mensagem de teste'

#List of items to be picked up
var pickup_item_list = ["soma", "subtracao", "multi", "print", "print", "print", "if/else"]

func _ready():
    var input_text = get_node("InputOutput/InputBase/Input")
    input_text.newline()
    input_text.add_text(String(INPUT))
    emit_signal("input_output_defined", INPUT, OUTPUT)
    get_tree().paused = true

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen
    
func _on_NextLevel_pressed():
    get_tree().change_scene("res://Level1/Level1.tscn")
