extends Node

func _init():
    pass

func execute(input, arguments, player_answer):
    arguments = arguments.split(", ")
    
    #Arguments check
    if (arguments.size() < 2):
        #wrong_arguments_message()
        return [null, true]
    #Accepting "input" as part of operations    
    if (arguments[0] == 'input'):
        arguments[0] = input
    if (arguments[1] == 'input'):
        arguments[1] = input
    #Checking types to perform the right "-" operation            
    if (arguments[0].is_valid_integer() and arguments[1].is_valid_integer()):
        return [(int(arguments[0]) - int(arguments[1])), true]
    elif (arguments[0].is_valid_float() and arguments[1].is_valid_float()):
        return [(float(arguments[0]) - float(arguments[1])), true]
    #This one is for Strings        
    else:
        return [null, true]