extends Control

signal reset_level()

func _on_ResetButton_pressed():
    emit_signal("reset_level")
