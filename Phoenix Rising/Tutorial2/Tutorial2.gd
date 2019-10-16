extends Node

signal input_output_defined(input, output)

#INPUT is a list of inputs to be given, one at time, to be processed
const INPUT = ['']
#OUTPUT is the expected string
const OUTPUT = ''

#List of items to be picked up (write one name for each position
#it will be picked up 1 item for each name position)
var pickup_item_list = []

func _ready():
    var InputText = get_node("InputOutput/InputBase/Input")
    InputText.newline()
    InputText.add_text(String(INPUT))
    emit_signal("input_output_defined", INPUT, OUTPUT)
    $NextLevel.hide()
    GlobalVariables.current_level = 1
    get_tree().paused = true

#Makes the game enter FULLSCREEN
func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen

#Returns to title screen
func _on_ReturnToTitle_pressed():
    get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
    
#Shows the next level button when the level is succeded
func _on_RunEnvironment_level_succeded():
    $NextLevel.show()
    
#Changes to the next level
func _on_NextLevel_next_level():
    get_tree().change_scene("res://Tutorial3/Tutorial3.tscn")

#Resets the level
func _on_ResetLevel_reset_level():
    get_tree().change_scene("res://Tutorial2/Tutorial2.tscn")

