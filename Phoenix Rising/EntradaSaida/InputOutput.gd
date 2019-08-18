extends Control

signal start_input_entered()
signal finish_input_entered()
signal start_input_exited()
signal finish_input_exited()

onready var connected_texture = preload("res://Acessorios/art/input_output_with_connection.png")
onready var not_connected_texture = preload("res://Acessorios/art/input_output_no_connection.png")

func _on_StartInputArea_area_entered(area):
    $StartInputArea/Sprite.texture = connected_texture
    emit_signal("start_input_entered")
    
func _on_StartInputArea_area_exited(area):
    $StartInputArea/Sprite.texture = not_connected_texture
    emit_signal("start_input_exited")

func _on_FinishInputArea_area_entered(area):
    $FinishInputArea/Sprite.texture = connected_texture
    emit_signal("finish_input_entered")

func _on_FinishInputArea_area_exited(area):
    $FinishInputArea/Sprite.texture = not_connected_texture
    emit_signal("finish_input_exited")
