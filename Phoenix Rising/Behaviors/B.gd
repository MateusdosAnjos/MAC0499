extends Node

func execute(input, arguments, player_answer, action_number):
    get_parent().variable_dict["B"] = 8
    print(get_parent().variable_dict)
    return [input, true]
