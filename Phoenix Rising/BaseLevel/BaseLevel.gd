#Rename the root to Levelx
#Create a new script called Levelx.gd and attach it here
#This is the template
extends Node

signal input_output_defined(input, output)

#Input and Output of the level, replace it to customize you own level
#INPUT is a list of inputs to be given, one at time, to be processed
const INPUT = ['Base Level']
#OUTPUT is the expected string
const OUTPUT = 'Base Level '

#List of items to be picked up (write one name for each position
#it will be picked up 1 item for each name position)
var pickup_item_list = ["print"]

func _ready():
    var InputText = get_node("InputOutput/InputBase/Input")
    InputText.newline()
    InputText.add_text(String(INPUT))
    emit_signal("input_output_defined", INPUT, OUTPUT)
    $NextLevel.hide()
    #Uncomment line 23 if you want to freeze the game until messages of Users Guide terminates
    #or until it sets the get_tree().paused = false
    get_tree().paused = true

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen

#Returns to title screen
func _on_ReturnToTitle_pressed():
    get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
    
#Shows the next level button when the level is succeded
func _on_RunEnvironment_level_succeded():
    $NextLevel.show()
    
func _on_NextLevel_next_level():
    get_tree().change_scene("res://Tutorial/Tutorial.tscn")

func _on_ResetLevel_reset_level():
    get_tree().change_scene("res://BaseLevel/BaseLevel.tscn")


