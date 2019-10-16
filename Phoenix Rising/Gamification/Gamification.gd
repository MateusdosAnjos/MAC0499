extends Control

var seconds_left = 120
var seconds_left_on_attempt = 0

func _ready():
    $OneSecond.start()
    $Stopwatch.set_text(str(seconds_left))
    $TotalPoints.set_text(str(GlobalVariables.total_points))
    
func _on_OneSecond_timeout():
    seconds_left -= 1
    $Stopwatch.set_text(str(seconds_left))

func _on_RunEnvironment_attempt_to_run():
    seconds_left_on_attempt = seconds_left

func _on_RunEnvironment_points_garanted():
    if !GlobalVariables.level_done[GlobalVariables.current_level]:
        GlobalVariables.total_points += seconds_left_on_attempt
        $TotalPoints.set_text(str(GlobalVariables.total_points))
        GlobalVariables.level_done[GlobalVariables.current_level] = true
