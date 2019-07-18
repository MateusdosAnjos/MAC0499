extends Button

func _ready():
    $Argument.hide()

func _on_ArgumentButton_pressed():
    $Argument.show()
    
func _on_ArgumentOk_pressed():
    self.text = $Argument.text
    $Argument.hide()
