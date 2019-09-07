extends Area2D

signal start_input_visual_entered()

func _on_VisualArea_area_entered(area):
    emit_signal("start_input_visual_entered")
