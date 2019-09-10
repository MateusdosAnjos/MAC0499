extends Node

func execute(input, arguments, player_answer, action_number):
    if (not arguments.empty()):
        if (arguments == 'input'):
            player_answer.append(input)
        else:
            return $ErrorMessages.show_error_message("print", action_number)   
    else:
        return $ErrorMessages.show_error_message("print", action_number)  
    return [input, true]