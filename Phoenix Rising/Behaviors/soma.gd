extends Node

var variable_dict = get_parent().variable_dict

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
            if (input.is_valid_integer()):
                values.set(i, int(input))
            else:
                values[i] = str("'", input, "'")
        elif (values[i] in variable_dict):
            if (variable_dict[values[i]].is_valid_integer()):
                values.set(i, int(variable_dict[values[i]]))
            else:
                values[i] = str("'", variable_dict[values[i]], "'")
    return values
                
func execute(input, arguments, action_number):
    var values = _split_arguments(arguments)
    if (values != null):
        values = _prepare_values(values, input)
        if (values[0].is_valid_integer() and values[1].is_valid_integer()):
            return [(int(values[0]) + int(values[1])), true]
        elif (values[0].is_valid_float() and values[1].is_valid_float()):
            return [(float(values[0]) + float(values[1])), true]      
        else:
            if (_string_check(values[0]) and _string_check(values[1])):
                return [(values[0].substr(1, values[0].length()-2) + values[1].substr(1, values[1].length()-2)), true]
    return $ErrorMessages.show_error_message("soma", action_number)
