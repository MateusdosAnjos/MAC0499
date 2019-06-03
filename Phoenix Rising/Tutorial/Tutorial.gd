extends Node

func _ready():
    pass # Replace with function body.

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen
    

func _on_Nivel_1_pressed():
    get_tree().change_scene("res://Nivel1/Nivel1.tscn")
