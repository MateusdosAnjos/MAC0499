extends Node

func execute(input, arguments, action_number):
    if (not arguments.empty()):
        return $ErrorMessages.show_error_message("pass", action_number)  
    return [input, true]