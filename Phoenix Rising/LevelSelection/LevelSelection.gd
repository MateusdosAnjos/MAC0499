extends Control

onready var level_dict = {
    "Tutorial": "res://Tutorial/Tutorial.tscn",
    "Nível 1": "res://Level1/Level1.tscn",
    "Nível 2": "res://Level2/Level2.tscn",
    "Nível 3": "res://Level3/Level3.tscn",
    "Nível 4": "res://Level4/Level4.tscn",
    }

func _on_level_selected(level_name):
    var level_path = level_dict[level_name]
    get_tree().change_scene(level_path)

func _on_ReturnToTitle_pressed():
    get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
