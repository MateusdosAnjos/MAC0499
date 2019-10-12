extends Control

signal variable_changed(variable, value)

# Variables dictionary
onready var variable_dict = null

func _on_RunEnvironment_dict_defined(dict):
    variable_dict = dict

################################################################################
#                  INPUT CHECKING AND INPUT FORMATTING FUNCTIONS               #
################################################################################
#Verify if there is the correct number of arguments
func _split_arguments(arguments):
    if (not arguments.empty()):
        var values = arguments.split(", ", false, 1)
        if (values.size() < 2):
            return null
        else:
            return values
    else:
        return null

#Checks if the string is enclosed in quotation marks
func _string_check(word):
    if (word[0] != "'" and word[0] != '"'):
        return false
    if (word[0] != word[word.length()-1]):
        return false
    return true

#Prepares the values in case the arguments are 'input' or a variable name
func _prepare_values(values, input):
    for i in range (2):
        if (values[i] == 'input'):
            if (_is_valid_integer(input)):
                values.set(i, int(input))
            else:
                values[i] = str("'", input, "'")
        elif (values[i] in variable_dict):
            if (_is_valid_integer(variable_dict[values[i]])):
                values.set(i, int(variable_dict[values[i]]))
            else:
                values[i] = str("'", variable_dict[values[i]], "'")
    return values

#Checks if value is a valid integer  
func _is_valid_integer(value):
    if (typeof(value) == TYPE_INT):
        return true
    elif (value.is_valid_integer()):
        return true
    else:
        return false
        
#Checks if the argument starts and end with " " or ' '
func _argument_check(arguments, word_length):
    if ((arguments[0] == '"' and arguments[word_length-1] == '"') or (arguments[0] == "'" and arguments[word_length-1] == "'")):
        return true
    return false        
################################################################################
#                         PRINT EXECUTE FUNCTION                               #
################################################################################        
func execute_print(input, arguments, action_number):
    if (not arguments.empty()):
        if (arguments == 'input'):
            get_parent().set_answer_on_screen(str(input) + " ")
        elif (arguments in variable_dict):
            get_parent().set_answer_on_screen(str(variable_dict[arguments]) + " ")
        else:
            return [$ErrorMessages.show_error_message("print", action_number), true]
    else:
        return [$ErrorMessages.show_error_message("print", action_number), true]
    return [input, true]

################################################################################
#                         SOMA  EXECUTE FUNCTION                               #
################################################################################
func execute_soma(input, arguments, action_number):
    var values = _split_arguments(arguments)
    if (values != null):
        values = _prepare_values(values, input)
        if (_is_valid_integer(values[0]) and _is_valid_integer(values[1])):
            return [(int(values[0]) + int(values[1])), true]
        elif (values[0].is_valid_float() and values[1].is_valid_float()):
            return [(float(values[0]) + float(values[1])), true]    
        else:
            if (_string_check(values[0]) and _string_check(values[1])):
                return [(values[0].substr(1, values[0].length()-2) + values[1].substr(1, values[1].length()-2)), true]
    return [$ErrorMessages.show_error_message("soma", action_number), true]
    
################################################################################
#                         SUBTRACAO  EXECUTE FUNCTION                          #
################################################################################
func execute_subtracao(input, arguments, action_number):
    var values = _split_arguments(arguments)
    if (values != null):        
        values = _prepare_values(values, input)
        if (values[0].is_valid_integer() and values[1].is_valid_integer()):
            return [(int(values[0]) - int(values[1])), true]
        elif (values[0].is_valid_float() and values[1].is_valid_float()):
            return [(float(values[0]) - float(values[1])), true]
    return [$ErrorMessages.show_error_message("subtracao", action_number), true]

################################################################################
#                      MULTIPLICACAO  EXECUTE FUNCTION                         #
################################################################################
func execute_multi(input, arguments, action_number):
    var values = _split_arguments(arguments)
    if (values != null):
        values = _prepare_values(values, input)
        #Checking types to perform the right "*" operation            
        if (values[0].is_valid_integer() and values[1].is_valid_integer()):
            return [(int(values[0]) * int(values[1])), true]
        elif (values[0].is_valid_float() and values[1].is_valid_float()):
            return [round((float(values[0])) * float(values[1])), true]  
        else:
            return [$ErrorMessages.show_error_message("multi", action_number), true]
    else:
        return [$ErrorMessages.show_error_message("multi", action_number), true]

################################################################################
#                      VARIABLES EXECUTE FUNCTIONS                             #
################################################################################    
func execute_variable_A(input, arguments, action_number):
    if (not arguments.empty()):
        if (arguments == 'input'):
            get_parent().variable_dict["A"] = input
        elif (_argument_check(arguments, len(arguments))):
            get_parent().variable_dict["A"] = arguments.substr(1, arguments.length()-2)
        elif (arguments.is_valid_integer()):
            get_parent().variable_dict["A"] = arguments
        else:
            return [$ErrorMessages.show_error_message("A", action_number), true]
    else:
        return [$ErrorMessages.show_error_message("A", action_number), true]
    emit_signal("variable_changed", "A", get_parent().variable_dict["A"])
    return [input, true]

func execute_variable_B(input, arguments, action_number):
    if (not arguments.empty()):
        if (arguments == 'input'):
            get_parent().variable_dict["B"] = input
        elif (_argument_check(arguments, len(arguments))):
            get_parent().variable_dict["B"] = arguments.substr(1, arguments.length()-2)
        elif (arguments.is_valid_integer()):
            get_parent().variable_dict["B"] = arguments
        else:
            return [$ErrorMessages.show_error_message("B", action_number), true]
    else:
        return [$ErrorMessages.show_error_message("B", action_number), true]
    emit_signal("variable_changed", "B", get_parent().variable_dict["B"])
    return [input, true]

################################################################################
#                           PASS EXECUTE FUNCTION                              #
################################################################################
func execute_pass(input, arguments, action_number):
    if (not arguments.empty()):
        return [$ErrorMessages.show_error_message("pass", action_number), true]
    return [input, true]
    
################################################################################
#                      ERROR SPRITE  EXECUTE FUNCTION                          #
################################################################################
func execute_error(input, arguments, action_number):
    return [$ErrorMessages.show_error_message("error", action_number), true]  