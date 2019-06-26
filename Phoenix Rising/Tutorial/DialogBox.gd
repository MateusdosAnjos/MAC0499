# DialogBox.gd
extends RichTextLabel

# Variables
var dialog = [
    "Bem vindo ao Phoenix Rising.",
    "Este é o tutorial.",
    "Agora adicionei algumas mensagens de teste.",
    ]
var page = 0
var maxPages = 2

onready var SkipButton = get_parent().get_node("Skip")

# Functions
func _ready():
    set_process_input(true)
    set_bbcode(dialog[page])
    set_visible_characters(0)
    

func _on_Timer_timeout():
    set_visible_characters(get_visible_characters()+1)
    if page == maxPages and get_visible_characters() > get_total_character_count():
        SkipButton.text = "Esconder"   
    
func _on_Skip_pressed():
        if SkipButton.text == "Esconder":
            get_parent().hide()
        else:    
            if get_visible_characters() > get_total_character_count():
                if page < dialog.size()-1:
                    page += 1
                    set_bbcode(dialog[page])
                    set_visible_characters(0)
            else:
                set_visible_characters(get_total_character_count())

