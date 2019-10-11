extends Control

# Variables dictionary
onready var variable_dict = null

func _on_RunEnvironment_dict_defined(dict):
    variable_dict = dict

################################################################################
#                         NODE INSERTION FUNCTION                              #
################################################################################     
func insert_node(CurrentNode, is_right_child):
    if (is_right_child):
        CurrentNode = CurrentNode.right_child
    else:
        CurrentNode = CurrentNode.left_child

################################################################################
#                  INPUT CHECKING AND INPUT FORMATTING FUNCTIONS               #
################################################################################
#Verify if there is the correct number of arguments
func _split_arguments(arguments):
    if (not arguments.empty()):
        var values = arguments.split(", ", false, 1)
        if (values.size() < 2):
            return null
        else:
            return values
    else:
        return null

#Checks if the string is enclosed in quotation marks
func _string_check(word):
    if (word[0] != "'" and word[0] != '"'):
        return false
    if (word[0] != word[word.length()-1]):
        return false
    return true

#Prepares the values in case the arguments are 'input' or a variable name
func _prepare_values(values, input):
    for i in range (2):
        if (values[i] == 'input'):
            if (_is_valid_integer(input)):
                values.set(i, int(input))
            else:
                values[i] = str("'", input, "'")
        elif (values[i] in variable_dict):
            if (_is_valid_integer(variable_dict[values[i]])):
                values.set(i, int(variable_dict[values[i]]))
            else:
                values[i] = str("'", variable_dict[values[i]], "'")
    return values

#Checks if value is a valid integer  
func _is_valid_integer(value):
    if (typeof(value) == TYPE_INT):
        return true
    elif (value.is_valid_integer()):
        return true
    else:
        return false  
        
################################################################################
#                         PRINT EXECUTE FUNCTION                               #
################################################################################        
func execute_print(input, arguments, action_number, CurrentNode):
    if (not arguments.empty()):
        if (arguments == 'input'):
            get_parent().set_answer_on_screen(str(input) + " ")
        elif (arguments in variable_dict):
            get_parent().set_answer_on_screen(str(variable_dict[arguments]) + " ")
        else:
            return $ErrorMessages.show_error_message("print", action_number)   
    else:
        return $ErrorMessages.show_error_message("print", action_number)
    #insert_node(CurrentNode, true) 
    return [input, true]

###############################################################################
#                         SOMA  EXECUTE FUNCTION                              #
###############################################################################                     
func execute_soma(input, arguments, action_number, CurrentNode):
    var values = _split_arguments(arguments)
    if (values != null):
        values = _prepare_values(values, input)
        if (_is_valid_integer(values[0]) and _is_valid_integer(values[1])):
            #insert_node(CurrentNode, true)
            return [(int(values[0]) + int(values[1])), true]
        elif (values[0].is_valid_float() and values[1].is_valid_float()):
            #insert_node(CurrentNode, true) 
            return [(float(values[0]) + float(values[1])), true]      
        else:
            if (_string_check(values[0]) and _string_check(values[1])):
                #insert_node(CurrentNode, true) 
                return [(values[0].substr(1, values[0].length()-2) + values[1].substr(1, values[1].length()-2)), true]
    return $ErrorMessages.show_error_message("soma", action_number)
