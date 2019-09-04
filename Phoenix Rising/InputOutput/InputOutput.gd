extends Control

signal start_input_entered(area)
signal start_input_exited()
signal start_input_position(pos)

onready var input_connected_texture = preload("res://Accessories/art/input_with_connection.png")
onready var input_not_connected_texture = preload("res://Accessories/art/input_no_connection.png")
onready var output_connected_texture = preload("res://Accessories/art/output_with_connection.png")
onready var output_not_connected_texture = preload("res://Accessories/art/output_no_connection.png")

var input_connected = false
var output_connected = false

func _ready():
    emit_signal("start_input_position", $StartInputArea.global_position)

func _on_StartInputArea_area_entered(area):
    $StartInputArea/Sprite.texture = input_connected_texture
    input_connected = true
    emit_signal("start_input_entered", area)
    
func _on_StartInputArea_area_exited(area):
    $StartInputArea/Sprite.texture = input_not_connected_texture
    input_connected = false
    emit_signal("start_input_exited")

func _on_FinishInputArea_area_entered(area):
    $FinishInputArea/Sprite.texture = output_connected_texture
    if area.get_parent().get_node("ActionNumber").text != "0":
        output_connected = true
    
func _on_FinishInputArea_area_exited(area):
    $FinishInputArea/Sprite.texture = output_not_connected_texture
    output_connected = false
