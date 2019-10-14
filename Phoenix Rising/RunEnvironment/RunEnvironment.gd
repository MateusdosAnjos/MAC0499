extends Control

class ActionNode:
    var node = null
    var right_child = null
    var left_child = null
    var function = null
    var arguments = null
    var action_number = null
    
signal frame_flashy(node_name, seconds)
signal level_succeded()
signal visual_process_arguments(path_points, input, function_tree)
signal dict_defined(dict)
signal clear_variables_map()

var input_list
var output

onready var InventoryNode = (self.owner).get_node('Inventory')
onready var InputOutputNode = get_parent().get_node("InputOutput")

onready var variable_dict = null

func _ready():
    variable_dict = { "A": "-", "B": "-" }
    emit_signal("dict_defined", variable_dict)
        
func _clean_dict():
    for item in variable_dict.keys():
        variable_dict[item] = "-"
    emit_signal("clear_variables_map")
          
func create_regex(regex_string):
    var regex = RegEx.new()
    regex.compile(str(regex_string))
    return regex
    
func _find_root():
    var regex = create_regex("MovableActionSpace*")
    for node in InventoryNode.get_children():
        if regex.search(node.get_name()) and node.get_node("ActionNumber").text == "1":
            return node

func _create_Action_Node(CurrentNode, function, arguments, action_number):
    var new_node = ActionNode.new()
    new_node.node = CurrentNode
    new_node.function = function
    new_node.arguments = arguments
    new_node.action_number = action_number
    return new_node

func _build_function_tree(CurrentNode):
    var NewNode = null
    if (CurrentNode == null or CurrentNode.name == "DummyNode" or CurrentNode.name == "InputOutput"):
        return null
    else:
        var CurrentActionSpace = CurrentNode.get_node("ActionSpace")
        if CurrentActionSpace.placed_item:
            var action_number = CurrentNode.get_node("ActionNumber").text
            var node_item = CurrentActionSpace.placed_item.get_meta("id")
            var input_process_code = ItemDB.get_item(node_item)["codePath"]
            var arguments = CurrentActionSpace.argument_list
            NewNode = _create_Action_Node(CurrentNode, funcref($RunScript, input_process_code), arguments, action_number)
            NewNode.right_child = _build_function_tree(CurrentNode.right_child)
            NewNode.left_child = _build_function_tree(CurrentNode.left_child)
    return NewNode
                                
func _process_input(input_list):
    var CurrentNode = _find_root()
    var function_tree = _build_function_tree(CurrentNode)
    for input in input_list:
        emit_signal("visual_process_arguments", input, function_tree)
        yield(get_parent().get_node("VisualProcess"), "end_path")
        if (not get_parent().get_node("VisualProcess").is_exit_sucess):
            return false
    return true

func set_answer_on_screen(answer):
    var PlayerOutput = get_parent().get_node("InputOutput/OutputBase/PlayerOutput")
    PlayerOutput.add_text(answer)
    return
    
func _success_routine():
    emit_signal("level_succeded")
    emit_signal("frame_flashy", "PlayerOutputFrame", 4)

func _failure_routine():
    emit_signal("frame_flashy", "PlayerOutputFrame", 4)  

func _is_system_connected(CurrentNode):
    if (CurrentNode == null or CurrentNode.name == "DummyNode"):
        return false
    else:
        if (CurrentNode.name == "InputOutput"):
            return true
        elif (CurrentNode.right_child != null):
            if (CurrentNode.left_child != null):
                return (_is_system_connected(CurrentNode.right_child) and _is_system_connected(CurrentNode.left_child))
            else:
                return (_is_system_connected(CurrentNode.right_child))
        else:
            return false

func _on_RunButton_pressed():
    var PlayerOutput = get_parent().get_node("InputOutput/OutputBase/PlayerOutput")
    PlayerOutput.clear()
    _clean_dict()
    if (_is_system_connected(_find_root())):
        var was_sucessfull = yield(_process_input(input_list), "completed")
        if (was_sucessfull):           
            var answer_string = PlayerOutput.text
            if (answer_string == output):
                _success_routine()
            else:
                _failure_routine()
        else:
            _failure_routine()
    
func _on_input_output_defined(inp, out):
    input_list = inp
    output = out
    var ExpectedOutput = get_parent().get_node("InputOutput/OutputBase/ExpectedOutput")
    ExpectedOutput.text = output
