extends Control

signal input_output_entered()
signal output_input_entered()
signal input_output_exited()
signal output_input_exited()

onready var connected_texture = preload("res://Acessorios/art/input_output_with_connection.png")
onready var not_connected_texture = preload("res://Acessorios/art/input_output_no_connection.png")

func _on_InputOutputArea_area_entered(area):
    $InputOutputArea/Sprite.texture = connected_texture
    emit_signal("input_output_entered")
    
func _on_InputOutputArea_area_exited(area):
    $InputOutputArea/Sprite.texture = not_connected_texture
    emit_signal("input_output_exited")

func _on_OutputInputArea_area_entered(area):
    $OutputInputArea/Sprite.texture = connected_texture
    emit_signal("output_input_entered")

func _on_OutputInputArea_area_exited(area):
    $OutputInputArea/Sprite.texture = not_connected_texture
    emit_signal("output_input_exited")
