extends Node

func _init():
    pass

func string_comparision_routine(input, arguments):
    print(arguments[1].casecmp_to("'Beleza'"))
    match arguments[0]:
        '<':
            return [input, input < str(arguments[1])] 
        '<=':
            return [input, input <= str(arguments[1])]
        '>':
            return [input, input > str(arguments[1])]
        '>=':
            return [input, input >= str(arguments[1])]
        '==':
            return [input, input == str(arguments[1])]
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
        string_comparision_routine(input, arguments)
    else:
       return number_comparision_routine(input, arguments)
