# UsersGuide.gd
extends Control

# Variables
var dialog = [
    'Bem vindo ao Phoenix Rising!\nPara jogar você deve terminar o tutorial.\nClique em "Pular" para ver a próxima mensagem.',
    'A partir do valor de [color=#00007f][b] ENTRADA [/b][/color] você deve obter o valor de [color=green][b] SAÍDA ESPERADA[/b][/color].\nVocê pode visualizar sua saída em [color=red][b] SAÍDA [/b][/color]',
    '[color=#00007f][b] ENTRADA [/b][/color] está marcada com o retângulo [color=#00007f][b] AZUL[/b][/color].',
    '[color=green][b] SAÍDA ESPERADA [/b][/color] está marcada com o retângulo [color=green][b] VERDE[/b][/color].',    
    '[color=red][b] SAÍDA [/b][/color] está marcada com o retângulo [color=red][b] VERMELHO[/b][/color].',  
    ]    
var visual_dialog_nodes = ["InputFrame", "ExpectedOutputFrame", "PlayerOutputFrame"]    
var page = 0
var max_pages = 4

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    for node_name in visual_dialog_nodes:
        get_node(node_name).hide()
        
func _process(delta):
    if page == 0:
        $InputFrame.play("flashy")
    if page == 1:    
        $InputFrame.stop()
        $ExpectedOutputFrame.play("flashy")
    if page == 2:
        $ExpectedOutputFrame.stop()
        $PlayerOutputFrame.play("flashy")
    if page == 3:
        $PlayerOutputFrame.stop()       
        
func _on_Timer_timeout():
    TextBox.set_visible_characters(TextBox.get_visible_characters()+1)
    if page == max_pages and TextBox.get_visible_characters() > TextBox.get_total_character_count():
        SkipButton.text = "Esconder"   
    
func _on_Skip_pressed():
    show_visual()
    if SkipButton.text == "Esconder":
        $DialogBox.hide()
        get_tree().paused = false
    else:    
        if TextBox.get_visible_characters() > TextBox.get_total_character_count():
            if page < dialog.size()-1:
                page += 1
                TextBox.set_bbcode(dialog[page])
                TextBox.set_visible_characters(0)
        else:
            TextBox.set_visible_characters(TextBox.get_total_character_count())

func show_visual():
    if page < 3:
        get_node(visual_dialog_nodes[page]).show()
    