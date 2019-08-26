# UsersGuide.gd
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)

# Variables
var dialog = [
    'Bem vindo ao Phoenix Rising!\nPara jogar você deve terminar o tutorial.\nClique em "Pular" para ver a próxima mensagem.',
    'A partir do valor de [color=#00007f][b] ENTRADA [/b][/color] você deve obter o valor de [color=green][b] SAÍDA ESPERADA[/b][/color].\nVocê pode visualizar sua saída em [color=red][b] SAÍDA [/b][/color]',
    '[color=#00007f][b] ENTRADA [/b][/color] está marcada com o retângulo [color=#00007f][b] AZUL[/b][/color].',
    '[color=green][b] SAÍDA ESPERADA [/b][/color] está marcada com o retângulo [color=green][b] VERDE[/b][/color].',    
    '[color=red][b] SAÍDA [/b][/color] está marcada com o retângulo [color=red][b] VERMELHO[/b][/color].',
    'Para obter a resposta você deve utilizar os comandos disponibilizados na sua [color=black][b] ÁREA DE COMANDOS[/b][/color].\nLembre-se de que nem sempre você precisará utilizar todos eles!',
    ]    
var visual_dialog_nodes = ["ColoredFrames/InputFrame", "ColoredFrames/ExpectedOutputFrame", "ColoredFrames/PlayerOutputFrame", "InventoryArrow"]    
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
        SkipButton.hide()  
    
func _on_Skip_pressed():
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
        emit_signal("frame_flashy", "InputFrame", 0)
    if page == 3:
        emit_signal("stop_flashy", "InputFrame")
        emit_signal("frame_flashy", "ExpectedOutputFrame", 0)
    if page == 4:
        emit_signal("stop_flashy", "ExpectedOutputFrame")
        emit_signal("frame_flashy", "PlayerOutputFrame", 0)
    if page == 5:
        emit_signal("stop_flashy", "PlayerOutputFrame")
        $InventoryArrow.show()
        $InventoryArrow.play("flashy")          

func _on_Close_pressed(): 
    if page == 0 or page == 1:
        get_node(visual_dialog_nodes[0]).show()
        get_node(visual_dialog_nodes[1]).show()   
        get_node(visual_dialog_nodes[2]).show()     
    if page == 2 or page == 3:
        emit_signal("stop_flashy", "InputFrame")
    if page == 3 or page == 4:
        emit_signal("stop_flashy", "ExpectedOutputFrame")
    if page == 4 or page == 5:
        emit_signal("stop_flashy", "PlayerOutputFrame")
        $InventoryArrow.show()
    $InventoryArrow.hide()    
    $DialogBox.hide()
    get_tree().paused = false  
