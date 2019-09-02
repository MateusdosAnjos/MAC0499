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
            
func number_comparision_routine(input, arguments, number_type):
    var compare_number = null
    if (number_type == TYPE_INT):
        compare_number = int(arguments[1])
    elif (number_type == TYPE_REAL):
        compare_number = float(arguments[1])
    match arguments[0]:
        '<':
            return [input, input < compare_number] 
        '<=':
            return [input, input <= compare_number]
        '>':
            return [input, input > compare_number]
        '>=':
            return [input, input >= compare_number]
        '==':
            return [input, input == compare_number]
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

#Checks if the arguments are correctly formated given the input.
#Returns null if it's not correctly formated
func _argument_check(input, arguments):
    if (arguments.empty()):
        return null
    var key_words = _split_arguments(arguments)
    if (key_words != null):
        if (typeof(input) == TYPE_STRING and key_words[1].length() > 2):
            if (key_words[1][0] != "'" and key_words[1][0] != '"'):
                return null
            if (key_words[1][0] != key_words[1][key_words[1].length()-1]):
                return null
        elif (typeof(input) == TYPE_INT):
            if (not key_words[1].is_valid_integer()):
                return null
        elif (typeof(input) == TYPE_REAL):
            if (not key_words[1].is_valid_float()):
                return null
        else:
            return null    
    return key_words
        
func execute(input, arguments, player_answer, action_number):
    var key_words = _argument_check(input, arguments)
    if (key_words != null):
        if (typeof(input) == TYPE_STRING):
            return string_comparision_routine(input, key_words)
        elif (typeof(input) == TYPE_INT):
           return number_comparision_routine(input, key_words, TYPE_INT)
        elif (typeof(input) == TYPE_REAL):
           return number_comparision_routine(input, key_words, TYPE_REAL)
    else:
        $ErrorMessages.show_error_message("if/else", action_number)
        return [input, false]
