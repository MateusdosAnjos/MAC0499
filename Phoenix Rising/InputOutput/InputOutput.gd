extends Control

signal start_input_entered(area)
signal start_input_exited()
signal start_input_position(pos)
signal output_position(pos)
signal start_input_visual_entered()
signal output_visual_entered()

onready var input_connected_texture = preload("res://Accessories/art/input_with_connection.png")
onready var input_not_connected_texture = preload("res://Accessories/art/input_no_connection.png")
onready var output_connected_texture = preload("res://Accessories/art/output_with_connection.png")
onready var output_not_connected_texture = preload("res://Accessories/art/output_no_connection.png")

func _ready():
    emit_signal("start_input_position", $StartInputArea.global_position)
    emit_signal("output_position", $FinishInputArea.global_position)

func _on_StartInputArea_area_entered(area):
    $StartInputArea/Sprite.texture = input_connected_texture
    emit_signal("start_input_entered", area)
    
func _on_StartInputArea_area_exited(area):
    $StartInputArea/Sprite.texture = input_not_connected_texture
    emit_signal("start_input_exited")

func _on_FinishInputArea_area_entered(area):
    $FinishInputArea/Sprite.texture = output_connected_texture
    while (not ("MovableActionSpace" in area.name)):
        area = area.get_parent()
    
func _on_FinishInputArea_area_exited(area):
    $FinishInputArea/Sprite.texture = output_not_connected_texture

func _on_StartInputArea_start_input_visual_entered():
    emit_signal("start_input_visual_entered")

func _on_FinishInputArea_output_visual_entered():
    emit_signal("output_visual_entered")
