extends Control

func _on_BaseLevelSelector_level_selected(path_to_level):
    get_tree().change_scene(path_to_level)
