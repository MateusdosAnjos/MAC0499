extends Node

func _init():
    pass

func execute(input, arguments, player_answer):
    if (not arguments.empty()):
        if (arguments != 'input'):
            player_answer.append(arguments)
        else:
            player_answer.append(input)   
    return [input, true]