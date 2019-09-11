extends Node
           
func execute(input, arguments, player_answer, action_number):
    print("Codigo de variáveis")
    get_parent().variable_dict["A"] = 3
    print(get_parent().variable_dict)
    return [input, true]
