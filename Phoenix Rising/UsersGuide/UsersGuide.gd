# UsersGuide.gd
extends Control

# Variables
var dialog = [
    'Bem vindo ao Phoenix Rising!\nPara jogar você deve terminar o tutorial.\nClique em "Pular" para ver a próxima mensagem.',
    'A partir do valor de [color=#00007f][b] ENTRADA [/b][/color] você deve obter o valor de [color=green][b] SAÍDA ESPERADA[/b][/color].\nVocê pode visualizar sua saída em [color=red][b] SAÍDA [/b][/color]',
    '[color=#00007f][b] ENTRADA [/b][/color] está marcada com o retângulo [color=#00007f][b] AZUL[/b][/color].',
    '[color=green][b] SAÍDA ESPERADA [/b][/color] está marcada com o retângulo [color=green][b] VERDE[/b][/color].',    
    '[color=red][b] SAÍDA [/b][/color] está marcada com o retângulo [color=red][b] VERMELHO[/b][/color].',
    'Para obter a resposta você deve utilizar os comandos disponibilizados na sua [color=black][b] ÁREA DE COMANDOS[/b][/color].\nLembre-se de que nem sempre você precisará utilizar todos eles!',
    ]    
var visual_dialog_nodes = ["InputFrame", "ExpectedOutputFrame", "PlayerOutputFrame", "InventoryArrow"]    
var page = 0
var max_pages = 5

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    for node_name in visual_dialog_nodes:
        get_node(node_name).hide()
            
func _on_Timer_timeout():
    TextBox.set_visible_characters(TextBox.get_visible_characters() + 1)
    if page == max_pages and TextBox.get_visible_characters() >= TextBox.get_total_character_count():
        SkipButton.text = "Esconder"   
    
func _on_Skip_pressed():
    if SkipButton.text == "Esconder":
        $DialogBox.hide()
        get_tree().paused = false
    else:    
        if TextBox.get_visible_characters() >= TextBox.get_total_character_count():
            if page < max_pages:
                page += 1
                TextBox.set_bbcode(dialog[page])
                TextBox.set_visible_characters(0)
                show_visuals()
        else:
            TextBox.set_visible_characters(TextBox.get_total_character_count())

func show_visuals():
    if page == 1:
        get_node(visual_dialog_nodes[0]).show()
        get_node(visual_dialog_nodes[1]).show()   
        get_node(visual_dialog_nodes[2]).show()         
    if page == 2:
        $InputFrame.play("flashy")
    if page == 3:
        $InputFrame.stop()
        $InputFrame.set_frame(0)
        $ExpectedOutputFrame.play("flashy")
    if page == 4:
        $ExpectedOutputFrame.stop()
        $ExpectedOutputFrame.set_frame(0)
        $PlayerOutputFrame.play("flashy")
    if page == 5:
        $PlayerOutputFrame.stop()
        $PlayerOutputFrame.set_frame(0)
        $InventoryArrow.show()
        $InventoryArrow.play("flashy")          

func _on_Close_pressed(): 
    if page == 0 or page == 1:
        get_node(visual_dialog_nodes[0]).show()
        get_node(visual_dialog_nodes[1]).show()   
        get_node(visual_dialog_nodes[2]).show()     
    if page == 2 or page == 3:
        $InputFrame.stop()
        $InputFrame.set_frame(0)
    if page == 3 or page == 4:
        $ExpectedOutputFrame.stop()
        $ExpectedOutputFrame.set_frame(0)
    if page == 4 or page == 5:
        $PlayerOutputFrame.stop()
        $PlayerOutputFrame.set_frame(0)
        $InventoryArrow.show()
    $InventoryArrow.hide()    
    $DialogBox.hide()
    get_tree().paused = false  
