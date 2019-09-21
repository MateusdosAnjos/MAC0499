extends Button

signal level_selected(path_to_level)

func _on_Select_pressed():
    var level_path = "res://LevelSelection/LevelSelection.tscn"
    emit_signal("level_selected", level_path)
