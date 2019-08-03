extends Node

func _init():
    pass

func execute(input, arguments):
    if (not arguments.empty()):
        if (arguments != 'input'):
            input.append(arguments)
    return input