extends Node

func execute(input, arguments, player_answer, action_number):
    arguments = arguments.split(", ")
    #Arguments check
    if (arguments.size() < 2):
        $ErrorMessages.show_error_message("multi", action_number)
        return [input, true]   
    if (arguments[0] == 'input'):
        arguments[0] = input
    if (arguments[1] == 'input'):
        arguments[1] = input
    #Checking types to perform the right "*" operation            
    if (arguments[0].is_valid_integer() and arguments[1].is_valid_integer()):
        return [(int(arguments[0]) * int(arguments[1])), true]
    elif (arguments[0].is_valid_float() and arguments[1].is_valid_float()):
        return [(float(arguments[0]) * float(arguments[1])), true]      
    else:
        $ErrorMessages.show_error_message("multi", action_number)
        return [input, true]
        