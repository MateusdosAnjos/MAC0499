extends Control

onready var VariablesText = get_node("VariableMapBox/VariablesText")

func _on_variable_changed(variable):
    VariablesText.text = str("Variável ", variable, " mudando papai")
    
