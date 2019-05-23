extends Control

func _ready():
    pass # Replace with function body.

func _on_NewGame_pressed():
    get_tree().change_scene("res://Main/Main.tscn")

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen