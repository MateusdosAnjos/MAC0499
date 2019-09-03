extends Control

signal frame_flashy(node_name, seconds)
signal level_succeded()

var input
var output

onready var InventoryNode = (self.owner).get_node('Inventory')
   
func create_regex(regex_string):
    var regex = RegEx.new()
    regex.compile(str(regex_string))
    return regex
    
func _find_root():
    var regex = create_regex("MovableActionSpace*")
    for node in InventoryNode.get_children():
        if regex.search(node.get_name()) and node.get_node("ActionNumber").text == "1":
            return node
                    
func _process_input(input):
    var processed_values = [input, true]
    var player_answer = []
    var arguments = null
    var node_item = null
    var input_process_code = null
    var CurrentActionSpace = null
    var action_number = 0
    
    var CurrentNode = _find_root()
    while CurrentNode != null and CurrentNode.name != "InputOutput":
        CurrentActionSpace = CurrentNode.get_node("ActionSpace")
        if CurrentActionSpace.placed_item:
            action_number = CurrentNode.get_node("ActionNumber").text
            node_item = CurrentActionSpace.placed_item.get_meta("id")
            input_process_code = load(ItemDB.get_item(node_item)["codePath"])
            $RunScript.set_script(input_process_code)
            arguments = CurrentActionSpace.argument_list
            processed_values = $RunScript.execute(processed_values[0], arguments, player_answer, action_number)
            if (processed_values == null):
                return player_answer
            if (processed_values[1]):
                CurrentNode = CurrentNode.right_child
            else:
                CurrentNode = CurrentNode.left_child
        else:
            CurrentNode = CurrentNode.right_child           
    return player_answer               

func _set_answer_on_screen(answer):
    var PlayerOutput = get_parent().get_node("InputOutput/OutputBase/PlayerOutput")
    PlayerOutput.text = answer
    return
    
func success_routine():
    emit_signal("level_succeded")
    emit_signal("frame_flashy", "PlayerOutputFrame", 4)

func failure_routine():
    emit_signal("frame_flashy", "PlayerOutputFrame", 4)  
     
func _on_RunButton_pressed():
    #if InputOutputNode.input_connected and InputOutputNode.output_connected:
    if true:
        var answer_list = _process_input(input)
        var answer_string = PoolStringArray(answer_list).join(" ")
        _set_answer_on_screen(answer_string)
        if (answer_string == output):
            success_routine()
        else:
            failure_routine()
    
func _on_input_output_defined(inp, out):
    input = inp
    output = out
    var ExpectedOutput = get_parent().get_node("InputOutput/OutputBase/ExpectedOutput")
    ExpectedOutput.text = output
