extends Control

onready var VariablesText = get_node("VariableMapBox/VariablesText")

func _on_variable_changed(variable, value):
    VariablesText.text = str("Variável ", variable, " = ", value)
    
