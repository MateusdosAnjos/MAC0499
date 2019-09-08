# TutorialGuide.gd
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)
signal hide_all()
signal show_all()

# Variables
var dialog = [
    'Bem vindo ao Phoenix Rising!\nPara jogar você deve terminar o tutorial.\nClique em "Pular" para ver a próxima mensagem.',
    'A ideia do jogo é obter o valor em [color=green][b] SAÍDA ESPERADA[/b][/color] a partir do valor de [color=#00007f][b] ENTRADA [/b][/color].\nVocê pode visualizar sua saída em [color=red][b] SUA SAÍDA [/b][/color] para acompanhar seu progresso.',
    '[color=#00007f][b] ENTRADA [/b][/color] está marcada com o retângulo [color=#00007f][b] AZUL[/b][/color].',
    '[color=green][b] SAÍDA ESPERADA [/b][/color] está marcada com o retângulo [color=green][b] VERDE[/b][/color].',    
    '[color=red][b] SUA SAÍDA [/b][/color] está marcada com o retângulo [color=red][b] VERMELHO[/b][/color].',
    'Agora vamos explicar como jogar:',
    'Para conseguir rodar seu programa você deve conectar o "input" com o "output".',
    'Utilize os "espaços de ação" para conectar o input com o output.\nQuando a conexão for estabelecida a cor mudará de vermelho para verde.',
    'Para mover o espaço de ação basta clicar e segurar com o botão esquerdo do mouse no ícone de movimento.\nApós isso mova o espaço de ação para o lugar que lhe parecer mais conveniente e solte o botão esquerdo do mouse.',
    'As áreas de conexão permitem que você conecte os espaços de ação.\nQuando uma conexão for estabelecida sua cor mudará de vermelho para verde.',
    'Você pode alterar as conexões de um "espaço de ação" clicando nos botões que alteram conexões.\nNote que algumas conexões são específicas para diferentes comandos, portanto fique atento.',
    'Para obter a resposta você deve utilizar os comandos disponibilizados na sua [color=black][b] ÁREA DE COMANDOS[/b][/color].\nLembre-se de que nem sempre você precisará utilizar todos eles!',
    ]    
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    emit_signal("hide_all")
    $InventoryArrow.hide()
            
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
        emit_signal("show_all")        
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
        emit_signal("show_all")    
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
