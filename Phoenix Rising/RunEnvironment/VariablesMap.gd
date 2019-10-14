extends Control

onready var VariablesTextA = get_node("VariablesTextA")
onready var VariablesTextB = get_node("VariablesTextB")

func _on_RunScript_variable_changed(variable, value):
    match variable:
        "A":
            VariablesTextA.text = str("Variável ", variable, " = ", value)
        "B":
            VariablesTextB.text = str("Variável ", variable, " = ", value)

func _on_RunEnvironment_clear_variables_map():
    VariablesTextA.text = str("Variável A = <Sem Valor>")
    VariablesTextB.text = str("Variável B = <Sem Valor>")
