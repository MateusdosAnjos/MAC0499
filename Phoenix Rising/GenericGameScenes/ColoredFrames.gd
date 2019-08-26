extends Control

#Makes the Animated sprite named 'node_name' flashes for the amount of 'seconds' seconds
#0 is the value for playing it until _stop_flashy is called
func _frame_flashy(node_name, seconds):
    var AnimatedSpriteName = get_node(node_name) 
    if seconds == 0:
        AnimatedSpriteName.play("flashy")
    else:  
        var animation_timer = Timer.new()
        animation_timer.set_wait_time(seconds)
        animation_timer.set_one_shot(true)
        self.add_child(animation_timer)
        animation_timer.start()
        AnimatedSpriteName.play("flashy")
        yield(animation_timer, "timeout")
        AnimatedSpriteName.set_frame(0)
        AnimatedSpriteName.stop()
        animation_timer.queue_free()

#Stops the animation "flashy" in the node named 'node_name'
func _stop_flashy(node_name):
    get_node(node_name).set_frame(0)
    get_node(node_name).stop()

#Signal from UsersGuide  
func _on_UsersGuide_frame_flashy(node_name, seconds):
    _frame_flashy(node_name, seconds)

#Signal from UsersGuide
func _on_UsersGuide_stop_flashy(node_name):
    _stop_flashy(node_name)
