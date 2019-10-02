extends Control

signal frame_flashy(node_name, seconds)
signal level_succeded()
signal visual_process_arguments(path_points, intermediate_inputs, input, functions, arguments_list, numbers)

var input_list
var output

onready var InventoryNode = (self.owner).get_node('Inventory')
onready var InputOutputNode = get_parent().get_node("InputOutput")

onready var variable_dict = { "A": "-", "B": "-" } 

func _clean_dict():
    for item in variable_dict.keys():
        variable_dict[item] = "-"
          
func create_regex(regex_string):
    var regex = RegEx.new()
    regex.compile(str(regex_string))
    return regex
    
func _find_root():
    var regex = create_regex("MovableActionSpace*")
    for node in InventoryNode.get_children():
        if regex.search(node.get_name()) and node.get_node("ActionNumber").text == "1":
            return node
                    
func _process_input(input_list):
    for input in input_list:
        var functions = []
        var arguments_list = []
        var numbers = []
        var processed_values = [input, true]
        var arguments = null
        var node_item = null
        var input_process_code = null
        var CurrentActionSpace = null
        var action_number = 0
        var path_points = []
        var intermediate_inputs = []
        var CurrentNode = _find_root()
        while CurrentNode != null and CurrentNode.name != "InputOutput":
            CurrentActionSpace = CurrentNode.get_node("ActionSpace")
            if CurrentActionSpace.placed_item:
                path_points.append(CurrentNode.global_position)
                action_number = CurrentNode.get_node("ActionNumber").text
                node_item = CurrentActionSpace.placed_item.get_meta("id")
                input_process_code = load(ItemDB.get_item(node_item)["codePath"])
                $RunScript.set_script(input_process_code)
                arguments = CurrentActionSpace.argument_list
                processed_values = $RunScript.execute(processed_values[0], arguments, action_number)
                functions.append(funcref($RunScript, "execute"))
                arguments_list.append(arguments)
                numbers.append(action_number)
                if (processed_values == null):
                    yield(get_tree(), "idle_frame")
                    return
                if (processed_values[1]):
                    CurrentNode = CurrentNode.right_child
                else:
                    CurrentNode = CurrentNode.left_child
                intermediate_inputs.append(processed_values[0])
            else:
                CurrentNode = CurrentNode.right_child
        emit_signal("visual_process_arguments", path_points, intermediate_inputs, input, functions, arguments_list, numbers)
        yield(get_parent().get_node("VisualProcess"), "end_path")
    return             

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
        var answer_list = yield(_process_input(input_list), "completed")
        var answer_string = PlayerOutput.text
        if (answer_string == output):
            _success_routine()
        else:
            _failure_routine()
    
func _on_input_output_defined(inp, out):
    input_list = inp
    output = out
    var ExpectedOutput = get_parent().get_node("InputOutput/OutputBase/ExpectedOutput")
    ExpectedOutput.text = output
