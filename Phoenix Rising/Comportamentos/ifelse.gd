extends Node

func _init():
    pass

func execute(input, arguments, player_answer):
    arguments = arguments.split(" ", true, 1)
    match arguments[0]:
        '<':
            return input < arguments[1]   
        '<=':
            return input <= arguments[1]
        '>':
            return input > arguments[1]
        '>=':
            return input >= arguments[1]
        '==':
            return input == arguments[1]
        _: print("Nenhuma das anteriores")