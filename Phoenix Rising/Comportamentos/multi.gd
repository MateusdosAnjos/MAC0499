extends Node

func _init():
    pass

func execute(input, arguments, player_answer):
    arguments = arguments.split(", ")
    if (arguments.size() < 2):
        #wrong_arguments_message()
        return null
    if (arguments[0].is_valid_integer() and arguments[1].is_valid_integer()):
        return (int(arguments[0]) * int(arguments[1]))
    elif (arguments[0].is_valid_float() and arguments[1].is_valid_float()):
        return (float(arguments[0]) * float(arguments[1]))    
    else:
        return null