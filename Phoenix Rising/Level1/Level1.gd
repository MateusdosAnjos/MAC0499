#Rename the root to Levelx
#Create a new script called Levelx.gd and attach it here
#This is the template
extends Node

signal input_output_defined(input, output)

#List of items to be picked up (write one name for each position
#it will be picked up 1 item for each name position)
var pickup_item_list = ["soma", "print"]

#Input and Output of the level, replace it to customize you own level
const INPUT = '-'
const OUTPUT = '8'

func _ready():
    var input_text = get_node("InputOutput/InputBase/Input")
    input_text.newline()
    input_text.add_text(String(INPUT))
    emit_signal("input_output_defined", INPUT, OUTPUT)
    #Uncomment line 16 if you want to freeze the game until messages of Users Guide terminates
    #or until it sets the get_tree().paused = false
    get_tree().paused = true

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen

func _on_NextLevel_next_level():
    get_tree().change_scene("res://Tutorial/Tutorial.tscn")

func _on_ResetLevel_reset_level():
    get_tree().change_scene("res://BaseLevel/BaseLevel.tscn")
