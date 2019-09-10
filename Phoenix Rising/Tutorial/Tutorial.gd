extends Node

signal input_output_defined(input, output)

const INPUT = 'Mensagem de teste'
const OUTPUT = 'Mensagem de teste'

#List of items to be picked up
var pickup_item_list = ["print"]

func _ready():
    var input_text = get_node("InputOutput/InputBase/Input")
    input_text.newline()
    input_text.add_text(String(INPUT))
    emit_signal("input_output_defined", INPUT, OUTPUT)
    $NextLevel.hide()
    get_tree().paused = true

#Makes the game enter FULLSCREEN
func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen

#Shows the next level button when the level is succeded
func _on_RunEnvironment_level_succeded():
    $NextLevel.show()
    
#Changes to the next level
func _on_NextLevel_next_level():
    get_tree().change_scene("res://Level1/Level1.tscn")

#Resets the level
func _on_ResetLevel_reset_level():
    get_tree().change_scene("res://Tutorial/Tutorial.tscn")
