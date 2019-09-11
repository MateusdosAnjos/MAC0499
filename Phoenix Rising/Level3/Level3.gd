extends Node

signal input_output_defined(input, output)

#List of items to be picked up (write one name for each position
#it will be picked up 1 item for each name position)
var pickup_item_list = ["multi", "print"]

#Input and Output of the level, replace it to customize you own level
const INPUT = '10'
const OUTPUT = '80'

func _ready():
    var input_text = get_node("InputOutput/InputBase/Input")
    input_text.newline()
    input_text.add_text(String(INPUT))
    emit_signal("input_output_defined", INPUT, OUTPUT)
    $NextLevel.hide()
    get_tree().paused = true

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen

#Shows the next level button when the level is succeded
func _on_RunEnvironment_level_succeded():
    $NextLevel.show()
    
func _on_NextLevel_next_level():
    get_tree().change_scene("res://Level4/Level4.tscn")

func _on_ResetLevel_reset_level():
    get_tree().change_scene("res://Level3/Level3.tscn")
