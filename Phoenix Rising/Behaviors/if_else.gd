extends Node

var variable_dict = get_parent().variable_dict

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

#Prepares the values in case the arguments is a variable name
func _prepare_values(values):
    for i in range (2):        
        if (values[i] in variable_dict):
            if (variable_dict[values[i]].is_valid_integer()):
                values.set(i, int(variable_dict[values[i]]))
            else:
                values[i] = str("'", variable_dict[values[i]], "'")
    return values

#Tries to split the arguments in 2. Returns the splited arguments in
#'values' and null if not successful
func _split_arguments(arguments):
    var values = arguments.split(" ", false, 1)
    if (values.size() < 2):
        return null
    else:
        return values
         
#Checks if the arguments are correctly formated given the input.
#Returns null if it's not correctly formated
func _argument_check(input, arguments):
    if (arguments.empty()):
        return null
    var values = _split_arguments(arguments)
    values = _prepare_values(values)
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
            
func execute(input, arguments, player_answer, action_number):
    if (input.is_valid_integer()):
        input = int(input)
    var values = _argument_check(input, arguments)
    if (values != null):
        if (typeof(input) == TYPE_STRING):
            return _string_comparision_routine(input, values, action_number)
        elif (typeof(input) == TYPE_INT):
           return _number_comparision_routine(input, values, TYPE_INT, action_number)
        elif (typeof(input) == TYPE_REAL):
           return _number_comparision_routine(input, values, TYPE_REAL, action_number)
    else:
        return $ErrorMessages.show_error_message("if/else", action_number)
