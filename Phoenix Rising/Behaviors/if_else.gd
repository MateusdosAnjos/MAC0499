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

#Tries to split the arguments in 2. Returns the splited arguments in
#'key_word' and null if not successful
func _split_arguments(arguments):
    var key_words = arguments.split(" ", false, 1)
    if (key_words.size() < 2):
        return null
    else:
        return key_words

#Checks if the arguments are correctly formated. Returns null if it's
#not correctly formated
func _argument_check(arguments):
    if (arguments.empty()):
        return null
    var key_words = _split_arguments(arguments)        
    return key_words
        
func execute(input, arguments, player_answer, action_number):
    var key_words = _argument_check(arguments)
    if (key_words != null):
        if (typeof(input) == TYPE_STRING) and (key_words[1][0] == '"' or key_words[1][0] == "'"):
            return string_comparision_routine(input, key_words)
        elif (typeof(input) == TYPE_INT):
           return number_comparision_routine(input, key_words)
    else:
        $ErrorMessages.show_error_message("if/else", action_number)
        return [input, false]
