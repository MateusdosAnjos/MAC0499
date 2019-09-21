extends Control

signal level_selected(level_name)

func _on_Select_level_selected(level_name):
    emit_signal("level_selected", level_name)
