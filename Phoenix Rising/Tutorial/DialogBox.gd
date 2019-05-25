# DialogBox.gd
extends RichTextLabel

# Variables
var dialog = [
    "Bem vindo ao Phoenix Rising.",
    "Este é o tutorial.",
    "Agora adicionei algumas mensagens de teste.",
    ]
var page = 0

# Functions
func _ready():
    set_process_input(true)
    set_bbcode(dialog[page])
    set_visible_characters(0)

func _on_Timer_timeout():
    set_visible_characters(get_visible_characters()+1)

func _on_DialogBox_pressed():
        if get_visible_characters() > get_total_character_count():
            if page < dialog.size()-1:
                page += 1
                set_bbcode(dialog[page])
                set_visible_characters(0)
        else:
            set_visible_characters(get_total_character_count())
