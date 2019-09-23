extends Node

signal variable_changed(variable, value)

#Checks if the argument starts and end with " " or ' '
func _argument_check(arguments, word_length):
    if ((arguments[0] == '"' and arguments[word_length-1] == '"') or (arguments[0] == "'" and arguments[word_length-1] == "'")):
        return true
    return false
    
func execute(input, arguments, action_number):
    connect("variable_changed", get_parent().get_node("VariablesMap"), "_on_variable_changed")
    if (not arguments.empty()):
        if (arguments == 'input'):
            get_parent().variable_dict["A"] = input
        elif (_argument_check(arguments, len(arguments))):
            get_parent().variable_dict["A"] = arguments.substr(1, arguments.length()-2)
        elif (arguments.is_valid_integer()):
            get_parent().variable_dict["A"] = arguments
        else:
            return $ErrorMessages.show_error_message("A", action_number)  
    else:
        return $ErrorMessages.show_error_message("A", action_number)
    emit_signal("variable_changed", "A", get_parent().variable_dict["A"])
    return [input, true]
