extends Node

func execute(input, arguments, player_answer, action_number):
    if (not arguments.empty()):
        return $ErrorMessages.show_error_message("pass", action_number)  
    return [input, true]