extends Control

var seconds_left = 120
var seconds_left_on_attempt = 0
var total_points

func _ready():
    $OneSecond.start()
    $Stopwatch.set_text(str(seconds_left))
    total_points = int($TotalPoints.get_text())
    
func _on_OneSecond_timeout():
    seconds_left -= 1
    $Stopwatch.set_text(str(seconds_left))

func _on_RunEnvironment_attempt_to_run():
    seconds_left_on_attempt = seconds_left

func _on_RunEnvironment_points_garanted():
    $TotalPoints.set_text(str(total_points + seconds_left_on_attempt))
