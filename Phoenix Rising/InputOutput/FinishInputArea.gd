extends Area2D

signal output_visual_entered()

func _on_VisualArea_area_entered(area):
    emit_signal("output_visual_entered")

