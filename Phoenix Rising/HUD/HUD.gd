extends CanvasLayer

signal start_game

func show_message(text):
    $Message.text = text
    $Message.show()
    $MessageTimer.start()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _on_StartButton_pressed():
    $StartButton.hide()
    $TitleScreenTimer.start()
    emit_signal("start_game")

func _on_MessageTimer_timeout():
    $Message.hide()

func _on_TitleScreenTimer_timeout():
    $Title.hide()
    $Author.hide()