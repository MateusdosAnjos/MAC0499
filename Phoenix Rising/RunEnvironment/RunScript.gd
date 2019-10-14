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
#           IF_ELSE INPUT CHECKING AND INPUT FORMATTING FUNCTIONS              #
################################################################################
#Tries to split the arguments in 2. Returns the splited arguments in
#'values' and null if not successful
func _if_else_split_arguments(arguments):
    var values = arguments.split(" ", false, 1)
    if (values.size() < 2):
        return null
    else:
        return values
        
#Prepares the values in case the arguments is a variable name
func _if_else_prepare_values(values):
    for i in range (2):        
        if (values[i] in variable_dict):
            if (variable_dict[values[i]].is_valid_integer()):
                values.set(i, int(variable_dict[values[i]]))
            else:
                values[i] = str("'", variable_dict[values[i]], "'")
    return values
    
#Checks if the arguments are correctly formated given the input.
#Returns null if it's not correctly formated
func _if_else_argument_check(input, arguments):
    if (arguments.empty()):
        return null
    var values = _if_else_split_arguments(arguments)
    values = _if_else_prepare_values(values)
    if (values != null):
        if (typeof(input) == TYPE_STRING and values[1].length() > 2):
            if (values[1][0] != "'" and values[1][0] != '"'):
                return null
            if (values[1][0] != values[1][values[1].length()-1]):
                return null
        elif (typeof(input) == TYPE_INT):
            if (not values[1].is_valid_integer()):
                return null
        elif (typeof(input) == TYPE_REAL):
            if (not values[1].is_valid_float()):
                return null
        else:
            return null    
    return values        
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
#                         IF_ELSE EXECUTE FUNCTION                             #
################################################################################
#Makes the lexicographic comparison between Strings
func _string_comparision_routine(input, arguments, action_number):
    var word_length = arguments[1].length()
    var word = arguments[1].substr(1, word_length - 2)
    match arguments[0]:
        '<':
            if (input.nocasecmp_to(word) == -1):
                return [input, true]
            else:
                return [input, false]
        '<=':
            if (input.nocasecmp_to(word) == -1 or input.nocasecmp_to(word) == 0):
                return [input, true]
            else:
                return [input, false]
        '>':
            if (input.nocasecmp_to(word) == 1):
                return [input, true]
            else:
                return [input, false]
        '>=':
            if (input.nocasecmp_to(word) == 1 or input.nocasecmp_to(word) == 0):
                return [input, true]
            else:
                return [input, false]
        '==':
            if (input.nocasecmp_to(word) == 0):
                return [input, true]
            else:
                return [input, false]
        _:
            return $ErrorMessages.show_error_message("if/else", action_number)

#Makes the number comparision based on number_type           
func _number_comparision_routine(input, arguments, number_type, action_number):
    var compare_number = null
    if (number_type == TYPE_INT):
        compare_number = int(arguments[1])
    elif (number_type == TYPE_REAL):
        compare_number = float(arguments[1])
    match arguments[0]:
        '<':
            return [input, input < compare_number] 
        '<=':
            return [input, input <= compare_number]
        '>':
            return [input, input > compare_number]
        '>=':
            return [input, input >= compare_number]
        '==':
            return [input, input == compare_number]
        _:
            return $ErrorMessages.show_error_message("if/else", action_number)
        
func execute_if_else(input, arguments, action_number):
    if (_is_valid_integer(input)):
        input = int(input)
    var values = _if_else_argument_check(input, arguments)
    if (values != null):
        if (typeof(input) == TYPE_STRING):
            return _string_comparision_routine(input, values, action_number)
        elif (typeof(input) == TYPE_INT):
           return _number_comparision_routine(input, values, TYPE_INT, action_number)
        elif (typeof(input) == TYPE_REAL):
           return _number_comparision_routine(input, values, TYPE_REAL, action_number)
    else:
        return $ErrorMessages.show_error_message("if/else", action_number)

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
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func execute_error(input, arguments, action_number):
    return [$ErrorMessages.show_error_message("error", action_number), true]  