extends Node

func string_comparision_routine(input, arguments):
    var word_length = arguments[1].length()
    var word = arguments[1].substr(1, word_length - 2)
    match arguments[0]:
        '<':
            if (input.nocasecmp_to(word) == -1):
                return [input, true]
            else:
                return [input, false]
        '<=':
            if (input.nocasecmp_to(word) == -1 or input.nocasecmp_to(word) == 0):
                return [input, true]
            else:
                return [input, false]
        '>':
            if (input.nocasecmp_to(word) == 1):
                return [input, true]
            else:
                return [input, false]
        '>=':
            if (input.nocasecmp_to(word) == 1 or input.nocasecmp_to(word) == 0):
                return [input, true]
            else:
                return [input, false]
        '==':
            if (input.nocasecmp_to(word) == 0):
                return [input, true]
            else:
                return [input, false]
        _:
            #wrong_arguments_message()
            print("Nenhuma das anteriores")
            
func number_comparision_routine(input, arguments):
    match arguments[0]:
        '<':
            return [input, input < int(arguments[1])] 
        '<=':
            return [input, input <= int(arguments[1])]
        '>':
            return [input, input > int(arguments[1])]
        '>=':
            return [input, input >= int(arguments[1])]
        '==':
            return [input, input == int(arguments[1])]
        _:
            #wrong_arguments_message()
            print("Nenhuma das anteriores")

func execute(input, arguments, player_answer):
    arguments = arguments.split(" ", true, 1)
    if arguments[1][0] == '"' or arguments[1][0] == "'":
        return string_comparision_routine(input, arguments)
    else:
       return number_comparision_routine(input, arguments)
