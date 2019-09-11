extends Node

#Checks if the argument starts and end with " " or ' '
func _argument_check(arguments, word_length):
    if ((arguments[0] == '"' and arguments[word_length-1] == '"') or (arguments[0] == "'" and arguments[word_length-1] == "'")):
        return true
    return false
    
func execute(input, arguments, player_answer, action_number):
    if (not arguments.empty()):
        if (arguments == 'input'):
            get_parent().variable_dict["A"] = input
        elif (_argument_check(arguments, len(arguments))):
            get_parent().variable_dict["A"] = arguments.substr(1, arguments.length()-2)
        else:
            return $ErrorMessages.show_error_message("A", action_number)  
    else:
        return $ErrorMessages.show_error_message("A", action_number)
    print(get_parent().variable_dict)
    return [input, true]
