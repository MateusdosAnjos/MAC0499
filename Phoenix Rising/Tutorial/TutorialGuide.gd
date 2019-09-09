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
    'Para conseguir rodar seu programa você deve conectar o "Input" com o "Output"',
    'Utilize os "espaços de ação" para conectar o input com o output.',
    'Para mover o espaço de ação basta clicar e segurar com o botão esquerdo do mouse no ícone de movimento.\nApós isso mova o espaço de ação para o lugar que lhe parecer mais conveniente e solte o botão esquerdo do mouse.',
    'As áreas de conexão permitem que você conecte os espaços de ação.\nQuando uma conexão for estabelecida sua cor mudará de vermelho para verde.',
    'Você pode alterar as conexões de um espaço de ação clicando nos botões que alteram conexões.\nNote que algumas conexões são específicas para diferentes comandos, portanto fique atento.',
    'Após conectar o input com o output você deve utilizar os comandos disponibilizados na sua [color=black][b] ÁREA DE COMANDOS[/b][/color] para obter a resposta desejada.\nLembre-se de que nem sempre você precisará utilizar todos eles!',
    'Cada comando recebe "Argumentos" seguindo padrões diferentes. Para obter informações sobre tais parâmetros basta clicar sobre o comando com o botão direito do mouse que um menu de ajuda irá aparecer.\nVocê deve clicar em "Argumentos" para inserir os argumentos necessários e depois clicar em "Ok".',
    'Após conectar o "input" com o "output" e posicionar os comandos desejados você poderá rodar seu programa clicando no botão "rodar".\nIsso fará com que sua sequência de instruções seja processada. Caso você obtenha sucesso [color=red][b] SUA SAÍDA [/b][/color] ficará [color=green][b] VERDE[/b][/color] e você poderá avançar para o próximo nível, caso contrário permanecerá [color=red][b] VERMELHA [/b][/color].',
    'Você pode acompanhar o que está acontecendo com o input do seu programa vendo a animação que é gerada após clicar em "rodar" e poderá alterar a velocidade que é passada clicando no botão "Velocidade da Animação" e selecionando a velocidade desejada.',
    'Agora vamos completar o primeiro nível do tutorial:\nPosicione o espaço de ação e ligue o "Input" com o "Output" trocando as conexões de forma necessária.',
    'Arraste o comando "Print" para o espaço de ação e passe como argumento a palava "input" (sem aspas).\nIsso fará o input ser escrito em sua saída.',
    'Se fizer corretamente, estará pronto para avançar para o próximo nível!'
    ]    
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

var arrow_sprites = ['InventoryArrow', 'Output', 'Input', 'ActionRect', 'InputConnection', 'OutputConnection', 
'ChangeInput', 'ChangeOutput', 'DragButton', 'RunButton', 'ArgumentsButton', 'AnimationSpeed']

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    emit_signal("hide_all")
    _hide_arrows()
    
func _hide_arrows():
    for sprite in arrow_sprites:
        get_node(sprite).hide()
               
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

func _animation_show_and_play(node_name, animation):
    var AnimateNode = get_node(node_name)
    AnimateNode.show()
    AnimateNode.play(animation)

func _animation_stop_and_hide(node_name):
    var AnimateNode = get_node(node_name)
    AnimateNode.set_frame(0)
    AnimateNode.stop()
    AnimateNode.hide()
    
func show_visuals():
    match page:
        1:
            emit_signal("show_all")        
        2:
            emit_signal("frame_flashy", "InputFrame", 0)
        3:
            emit_signal("stop_flashy", "InputFrame")
            emit_signal("frame_flashy", "ExpectedOutputFrame", 0)
        4:
            emit_signal("stop_flashy", "ExpectedOutputFrame")
            emit_signal("frame_flashy", "PlayerOutputFrame", 0)
        5:
            emit_signal("stop_flashy", "PlayerOutputFrame")
        6:
            _animation_show_and_play("Input", "flashy")
            _animation_show_and_play("Output", "flashy")
        7:
            _animation_stop_and_hide("Input")
            _animation_stop_and_hide("Output")
            _animation_show_and_play("ActionRect", "flashy")
        8:
            _animation_stop_and_hide("ActionRect")
            _animation_show_and_play("DragButton", "flashy")
        9:
            _animation_stop_and_hide("DragButton")
            _animation_show_and_play("InputConnection", "flashy")
            _animation_show_and_play("OutputConnection", "flashy")
        10:
            _animation_stop_and_hide("InputConnection")
            _animation_stop_and_hide("OutputConnection")
            _animation_show_and_play("ChangeInput", "flashy")
            _animation_show_and_play("ChangeOutput", "flashy")
        11:
            _animation_stop_and_hide("ChangeInput")
            _animation_stop_and_hide("ChangeOutput")
            _animation_show_and_play("InventoryArrow", "flashy")
        12:
            _animation_stop_and_hide("InventoryArrow")
            _animation_show_and_play("ArgumentsButton", "flashy")
        13:
            _animation_stop_and_hide("ArgumentsButton")
            _animation_show_and_play("RunButton", "flashy")
        14:
            _animation_stop_and_hide("RunButton")
            _animation_show_and_play("AnimationSpeed", "flashy")
        15:
            _animation_stop_and_hide("AnimationSpeed")

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
    _hide_arrows()    
    $DialogBox.hide()
    get_tree().paused = false  
