extends Control

signal level_selected(path_to_level)

func _on_Select_level_selected(path_to_level):
    emit_signal("level_selected", path_to_level)
