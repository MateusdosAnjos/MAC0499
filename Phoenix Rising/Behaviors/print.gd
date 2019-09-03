extends Node

#Checks if the argument starts and end with " " or ' '
func _argument_check(arguments, word_length):
    if ((arguments[0] == '"' and arguments[word_length-1] == '"') or (arguments[0] == "'" and arguments[word_length-1] == "'")):
        return true

func execute(input, arguments, player_answer, action_number):
    if (not arguments.empty()):
        if (arguments != 'input'):
            var word_length = arguments.length()
            if (_argument_check(arguments, word_length)):
                var word = arguments.substr(1, word_length - 2)
                player_answer.append(word)
            else:
                return $ErrorMessages.show_error_message("print", action_number)
        else:
            player_answer.append(input)
    else:
        return $ErrorMessages.show_error_message("print", action_number)  
    return [input, true]