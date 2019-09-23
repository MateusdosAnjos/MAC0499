extends Node

var variable_dict = get_parent().variable_dict

func execute(input, arguments, action_number):
    if (not arguments.empty()):
        if (arguments == 'input'):
            #player_answer.append(input)
            get_parent().set_answer_on_screen(str(input) + " ")
        elif (arguments in variable_dict):
            #player_answer.append(variable_dict[arguments])
            get_parent().set_answer_on_screen(str(variable_dict[arguments]) + " ")
        else:
            return $ErrorMessages.show_error_message("print", action_number)   
    else:
        return $ErrorMessages.show_error_message("print", action_number)  
    return [input, true]