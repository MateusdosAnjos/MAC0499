# DialogBox.gd
extends RichTextLabel

# Variables
var dialog = [
    'Bem vindo ao Phoenix Rising!\nPara jogar você deve terminar o tutorial.\nClique em "Pular" para ir para a próxima mensagem.',
    "Eita lasquera",
    ]
var page = 0
var max_pages = 1

onready var SkipButton = get_parent().get_node("Skip")

# Functions
func _ready():
    set_process_input(true)
    set_bbcode(dialog[page])
    set_visible_characters(0)
    

func _on_Timer_timeout():
    set_visible_characters(get_visible_characters()+1)
    if page == max_pages and get_visible_characters() > get_total_character_count():
        SkipButton.text = "Esconder"   
    
func _on_Skip_pressed():
        if SkipButton.text == "Esconder":
            get_parent().hide()
            get_tree().paused = false
        else:    
            if get_visible_characters() > get_total_character_count():
                if page < dialog.size()-1:
                    page += 1
                    set_bbcode(dialog[page])
                    set_visible_characters(0)
            else:
                set_visible_characters(get_total_character_count())

