extends Node

var variable_dict = get_parent().variable_dict

func insert_node(CurrentNode, is_right_child):
    if (is_right_child):
        CurrentNode = CurrentNode.right_child
    else:
        CurrentNode = CurrentNode.left_child

func execute(input, arguments, action_number, CurrentNode):
    if (not arguments.empty()):
        if (arguments == 'input'):
            get_parent().set_answer_on_screen(str(input) + " ")
        elif (arguments in variable_dict):
            get_parent().set_answer_on_screen(str(variable_dict[arguments]) + " ")
        else:
            return $ErrorMessages.show_error_message("print", action_number)   
    else:
        return $ErrorMessages.show_error_message("print", action_number)
    insert_node(CurrentNode, true)
    return [input, true]