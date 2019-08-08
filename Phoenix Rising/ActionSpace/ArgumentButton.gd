extends Button

signal sent_arguments(arguments)

func _ready():
    $Argument.hide()

func _on_ArgumentButton_pressed():
    $Argument.show()
    
func _on_ArgumentOk_pressed():
    if $Argument.get_text() == '':
        self.text = "Argumentos" 
    else:    
        self.text = $Argument.text
    emit_signal("sent_arguments", $Argument.text)
    $Argument.hide()
