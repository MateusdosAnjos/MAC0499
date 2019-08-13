# DialogBox.gd
extends RichTextLabel

# Variables
var dialog = [
    'Bem vindo ao Phoenix Rising!\nPara jogar você deve terminar o tutorial.\nClique em "Pular" para ver a próxima mensagem.',
    'A partir do valor de [color=green][b] ENTRADA [/b][/color] você deve obter o valor de SAÍDA que seja IGUAL ao valor descrito em SAÍDA ESPERADA',
    'Note que ENTRADA está marcada com o retângulo AZUL\nSAIDA ESPERADA está marcada com o retângulo VERMELHO\nSAIDA está marcada com o retângulo VERDE.'
    ]    
var visual_dialog_nodes = ["InputFrame", "ExpectedOutputFrame", "PlayerOutputFrame"]    
var page = 0
var max_pages = 2

onready var SkipButton = get_parent().get_node("Skip")

# Functions
func _ready():
    set_process_input(true)
    set_bbcode(dialog[page])
    set_visible_characters(0)
    for node_name in visual_dialog_nodes:
        get_parent().get_node(node_name).hide()

func _on_Timer_timeout():
    set_visible_characters(get_visible_characters()+1)
    if page == max_pages and get_visible_characters() > get_total_character_count():
        SkipButton.text = "Esconder"   
    
func _on_Skip_pressed():
    show_visual()
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

func show_visual():
    get_parent().get_node(visual_dialog_nodes[page]).show()