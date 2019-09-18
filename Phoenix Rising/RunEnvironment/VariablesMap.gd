extends Control

onready var VariablesTextA = get_node("VariablesTextA")
onready var VariablesTextB = get_node("VariablesTextB")

func _on_variable_changed(variable, value):
    match variable:
        "A":
            VariablesTextA.text = str("Variável ", variable, " = ", value)
        "B":
            VariablesTextB.text = str("Variável ", variable, " = ", value)
            