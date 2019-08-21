extends Node

func _init():
    pass

func execute(input, arguments, player_answer):
    arguments = arguments.split(" ", true, 1)
    match arguments[0]:
        '<':
            return [0, input < int(arguments[1])] 
        '<=':
            return [0, input <= arguments[1]]
        '>':
            return [0, input > int(arguments[1])]
        '>=':
            return [0, input >= arguments[1]]
        '==':
            return [0, input == arguments[1]]
        _:
            #wrong_arguments_message()
            print("Nenhuma das anteriores")