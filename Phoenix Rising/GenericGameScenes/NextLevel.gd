extends Control

signal next_level()

func _on_NextLevelButton_pressed():
    emit_signal("next_level")
    