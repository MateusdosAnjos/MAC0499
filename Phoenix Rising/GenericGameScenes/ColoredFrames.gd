extends Control

func _ready():
    $PlayerOutputFrame.set_animation("flashy")

#Makes the Animated sprite named 'node_name' flashes for the amount of 'seconds' seconds
#0 is the value for playing it until _stop_flashy is called
func _frame_flashy(node_name, seconds):
    var AnimatedSpriteName = get_node(node_name) 
    if seconds == 0:
        AnimatedSpriteName.play()
    else:  
        var animation_timer = Timer.new()
        animation_timer.set_wait_time(seconds)
        animation_timer.set_one_shot(true)
        self.add_child(animation_timer)
        animation_timer.start()
        AnimatedSpriteName.play()
        yield(animation_timer, "timeout")
        AnimatedSpriteName.set_frame(0)
        AnimatedSpriteName.stop()
        animation_timer.queue_free()

#Stops the animation "flashy" in the node named 'node_name'
func _stop_flashy(node_name):
    get_node(node_name).set_frame(0)
    get_node(node_name).stop()

###############################################################
#                  Signals from UsersGuide                    #
###############################################################
func _on_UsersGuide_frame_flashy(node_name, seconds):
    _frame_flashy(node_name, seconds)

func _on_UsersGuide_stop_flashy(node_name):
    _stop_flashy(node_name)

###############################################################
#              Signals from Run (RunEnvironment.gd)           #
###############################################################
func _on_RunEnvironment_level_succeded():
    $PlayerOutputFrame.set_animation("success_flashy")

func _on_RunEnvironment_frame_flashy(node_name, seconds):
    _frame_flashy(node_name, seconds)
