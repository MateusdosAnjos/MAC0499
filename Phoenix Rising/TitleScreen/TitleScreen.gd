extends Control

func _ready():
    pass # Replace with function body.

func _on_NewGame_pressed():
    get_tree().change_scene("res://Tutorial/Tutorial.tscn")

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen

func _on_LevelSelect_pressed():
    get_tree().change_scene("res://LevelSelection/LevelSelection.tscn")
