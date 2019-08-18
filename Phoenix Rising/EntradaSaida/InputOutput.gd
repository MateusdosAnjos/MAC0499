extends Control

signal start_input_entered(area)
signal finish_input_entered(area)
signal start_input_exited(area)
signal finish_input_exited(area)

onready var connected_texture = preload("res://Acessorios/art/input_output_with_connection.png")
onready var not_connected_texture = preload("res://Acessorios/art/input_output_no_connection.png")

func _on_StartInputArea_area_entered(area):
    $StartInputArea/Sprite.texture = connected_texture
    emit_signal("start_input_entered", area)
    
func _on_StartInputArea_area_exited(area):
    $StartInputArea/Sprite.texture = not_connected_texture
    emit_signal("start_input_exited", area)

func _on_FinishInputArea_area_entered(area):
    $FinishInputArea/Sprite.texture = connected_texture
    emit_signal("finish_input_entered", area)

func _on_FinishInputArea_area_exited(area):
    $FinishInputArea/Sprite.texture = not_connected_texture
    emit_signal("finish_input_exited", area)
