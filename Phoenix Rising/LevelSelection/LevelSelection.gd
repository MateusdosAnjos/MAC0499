extends Control

onready var level_dict = {
    "Tutorial": ["res://Tutorial/Tutorial.tscn", "Tutorial"],
    "Nível 1":  ["res://Level1/Level1.tscn", "Nível 1" ],
    "Nível 2":  ["res://Level2/Level2.tscn", "Nível 2"],
    "Nível 3":  ["res://Level3/Level3.tscn", "Nível 3"],
    "Nível 4":  ["res://Level4/Level4.tscn", "Nível 4"],
    }

func _on_level_selected(level_name):
    if level_name in level_dict:
        var level_path = (level_dict[level_name])[0]
        get_tree().change_scene(level_path)
    else:
        get_node("ErrorPopup/ErrorMessage").text = "Nível não implementado"
        get_node("ErrorPopup").popup()
        
func _on_level_description(level_name):
    var description_text = (level_dict[level_name])[1]
    var Description = get_node("DescriptionPopup/LevelDesciption")
    Description.text = description_text
    get_node("DescriptionPopup").popup()

func _on_ReturnToTitle_pressed():
    get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
