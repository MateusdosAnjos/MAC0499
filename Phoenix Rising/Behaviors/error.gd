extends Node

func execute(input, arguments, player_answer, action_number):
    return $ErrorMessages.show_error_message("error", action_number)  