extends Node

func _ready():
    pass # Replace with function body.

func _on_FullScreen_pressed():
    OS.window_fullscreen = !OS.window_fullscreen
