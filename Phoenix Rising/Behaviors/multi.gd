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
        
#Prepares the values in case the arguments are 'input' or a variable name
func _prepare_values(values, input):
    for i in range (2):        
        if (values[i] == 'input'):
            if (input.is_valid_integer()):
                values.set(i, int(input))
        elif (values[i] in variable_dict):
            if (variable_dict[values[i]].is_valid_integer()):
                values.set(i, int(variable_dict[values[i]]))
    return values
               
func execute(input, arguments, action_number):
    var values = _split_arguments(arguments)
    if (values != null):
        values = _prepare_values(values, input)
        #Checking types to perform the right "*" operation            
        if (values[0].is_valid_integer() and values[1].is_valid_integer()):
            return [(int(values[0]) * int(values[1])), true]
        elif (values[0].is_valid_float() and values[1].is_valid_float()):
            return [round((float(values[0])) * float(values[1])), true]      
        else:
            return $ErrorMessages.show_error_message("multi", action_number)
    else:
        return $ErrorMessages.show_error_message("multi", action_number)
        