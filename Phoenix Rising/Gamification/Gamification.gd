extends Control

var seconds_left = 120

func _ready():
    $OneSecond.start()
    $Stopwatch.set_text(str(seconds_left))
    
func _on_OneSecond_timeout():
    seconds_left -= 1  
    $Stopwatch.set_text(str(seconds_left))  
