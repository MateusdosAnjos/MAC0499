extends Control

signal start_input_entered(area)
signal finish_input_entered(area)
signal start_input_exited()
signal finish_input_exited()

onready var connected_texture = preload("res://Accessories/art/default_with_connection.png")
onready var not_connected_texture = preload("res://Accessories/art/default_no_connection.png")

func _on_StartInputArea_area_entered(area):
    $StartInputArea/Sprite.texture = connected_texture
    emit_signal("start_input_entered", area)
    
func _on_StartInputArea_area_exited(area):
    $StartInputArea/Sprite.texture = not_connected_texture
    emit_signal("start_input_exited")

func _on_FinishInputArea_area_entered(area):
    $FinishInputArea/Sprite.texture = connected_texture
    emit_signal("finish_input_entered", area)

func _on_FinishInputArea_area_exited(area):
    $FinishInputArea/Sprite.texture = not_connected_texture
    emit_signal("finish_input_exited")
