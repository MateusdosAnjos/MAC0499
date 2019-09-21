extends Button

signal level_description(level_name)

func _on_Description_pressed():
    var level_name = get_parent().get_node("LevelName").text
    emit_signal("level_selected", level_name)
