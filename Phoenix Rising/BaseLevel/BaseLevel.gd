extends Node

signal input_output_defined(input, output)

#Input of the level
const INPUT = 'Base Level Input'
const OUTPUT = 'Base Level Output'

func _ready():
    var input_text = get_node("InputOutput/InputBase/Input")
    input_text.newline()
    input_text.add_text(String(INPUT))
    emit_signal("input_output_defined", INPUT, OUTPUT)
    #Uncomment line 16 if you want to freeze the game until messages of Users Guide terminates
    #or until it sets the get_tree().paused = false
    #get_tree().paused = true

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen

func _on_NextLevel_pressed():
    #Replace "res://Level1/Level1.tscn" with the path to next level
    get_tree().change_scene("res://Level1/Level1.tscn")
