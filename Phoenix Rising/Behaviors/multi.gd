extends Node

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

func execute(input, arguments, player_answer, action_number):
    var values = _split_arguments(arguments)
    if (values != null):
        if (values[0] == 'input'):
            values[0] = input
        if (values[1] == 'input'):
            values[1] = input
        #Checking types to perform the right "*" operation            
        if (values[0].is_valid_integer() and values[1].is_valid_integer()):
            return [(int(values[0]) * int(values[1])), true]
        elif (values[0].is_valid_float() and values[1].is_valid_float()):
            return [(float(values[0]) * float(values[1])), true]      
        else:
            $ErrorMessages.show_error_message("multi", action_number)
            return [input, true]
    else:
        $ErrorMessages.show_error_message("multi", action_number)
        return [input, true]
        