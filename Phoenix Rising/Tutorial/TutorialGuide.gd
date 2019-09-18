# TutorialGuide.gd
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)
signal hide_all()
signal show_all()

# Variables
var dialog = [
    'Bem vindo ao Phoenix Rising!\n\nEste jogo é uma maneira lúdica de introduzir conceitos de programação!\n\nApesar do Tutorial parecer extenso é importantíssimo que você o leia com atenção!!\n\nClique em "Pular" para ver a próxima mensagem ou em fechar se já conhecer o jogo.',
    'Para facilitar a explicação faremos uma analogia entre este jogo e o processo de criação de um delicioso bolo de chocolate.\n\nPara fazer um bolo precisamos de INGREDIENTES como ovo, farinha e leite. Esses ingredientes serão fornecidos pelo INPUT, também conhecido como: [color=#00007f][b] ENTRADA [/b][/color].\n\nSeu objetivo será utilizar comandos (veremos o que é isso) para criar o que está sendo pedido em [color=green][b] SAÍDA ESPERADA [/b][/color] como se esses comandos fossem as ações a serem tomadas no modo de preparo do bolo.\nPor fim você pode acompanhar o resultado de sua receita em [color=red][b] SUA SAÍDA [/b][/color] para verificar se está próximo ou não do delicioso bolo de chocolate.',
    '[color=#00007f][b] ENTRADA [/b][/color], conhecida como INPUT, está marcada com o retângulo [color=#00007f][b] AZUL [/b][/color].\nOs valores a serem fornecidos como entrada (input) estão separados por vírgula, portanto ["ovo"] significa que, neste nível, apenas o valor "ovo" será fornecido. Caso a entrada seja ["ovo", "farinha"] será fornecido primeiro o "ovo" e ele passará pelas ações (modo de preparo) que você definiu. Após isso o valor "farinha" passará pela mesma sequência de ações.',
    '[color=green][b] SAÍDA ESPERADA [/b][/color] está marcada com o retângulo [color=green][b] VERDE [/b][/color].\nTe mostra qual o seu objetivo neste nível, ou seja, qual bolo queremos fazer.',    
    '[color=red][b] SUA SAÍDA [/b][/color] está marcada com o retângulo [color=red][b] VERMELHO [/b][/color].\nAqui você pode acompanhar qual bolo o seu modo de preparo (sequência de comandos) criou.\nVocê passará de nível quando o bolo criado for o mesmo que o bolo esperado, ou seja, quando a [color=red][b] SUA SAÍDA [/b][/color] for igual a [color=green][b] SAÍDA ESPERADA [/b][/color].',
    'Daremos algumas informações sobre os itens básicos deste jogo, se algo não for explicado agora não se preocupe:',
    'Para fazer com que o jogo execute as ações em seu modo de preparo você deve conectar o "Input" (de onde vem os ingredientes) com o "Output" (fim da receita), mostrando que existe um começo e um fim para sua receita e clicar no botão "Rodar!".',
    'Para conectar o "Input" com o "Output" você deve utilizar os "espaços de ação".\n\nEles são como as linhas escritas de uma receita, pois cada linha tem apenas uma instrução a ser executada, recebe algum ingrediente para "processar" e se  conecta de diferentes formas com as outras linhas.',
    'Para mover o espaço de ação basta clicar e segurar com o botão esquerdo do mouse no ícone de movimento (mãozinha).\n\nApós isso mova o espaço de ação para o lugar que lhe parecer mais conveniente e solte o botão esquerdo do mouse.\n\nLembre-se que os espaços de ação servem para conectar o Input com o Output e dar ordem a sua receita, eles são como linhas!',
    'As áreas de conexão permitem que você conecte os espaços de ação.\n\nDesta forma quando um ingrediente passar por uma ação (comando) ele irá para a próxima ação, como em uma receita efetuamos uma linha por vez.\n\nQuando uma conexão for estabelecida sua cor mudará de vermelho para verde.',
    'Você pode alterar as formas de conexões de um espaço de ação clicando nos botões que alteram conexões.\n\nNote que algumas conexões são específicas para diferentes comandos, portanto fique atento às instruções de outros níveis!',
    'Após conectar o input com o output você deve utilizar os comandos disponibilizados na sua [color=black][b] ÁREA DE COMANDOS[/b][/color] para obter a resposta desejada.\n\nEstes comandos são como as ações em uma receita, por exemplo: Mexer, Bater, Acrescentar, etc.\n\nLembre-se de que nem sempre você precisará utilizar todos eles!',
    'Nos espaços de ação você deve adicionar "Argumentos" para os diferentes comandos.\n\nEstes argumentos podem ser comparados a novos ingredientes ou até utensílios de uma receita, pois cada comando exige diferentes formatos de argumentos e as vezes você irá adicionar novos itens à sua receita.\n\nPara obter mais informações basta clicar sobre o comando (ação) com o botão direito do mouse que um menu de ajuda irá aparecer.\nVocê deve clicar em "Argumentos" para inserir os argumentos necessários e depois clicar em "Ok".',
    'Após conectar o "input" com o "output" e posicionar os comandos desejados você poderá executar seu programa (sua receita) clicando no botão "rodar".\nIsso fará com que sua sequência de instruções seja processada. Caso você obtenha sucesso [color=red][b] SUA SAÍDA [/b][/color] ficará [color=green][b] VERDE[/b][/color] e você poderá avançar para o próximo nível, caso contrário permanecerá [color=red][b] VERMELHA [/b][/color].',
    'Você pode acompanhar o que está acontecendo com o input do seu programa vendo a animação que é gerada após clicar em "rodar" e poderá alterar a velocidade que é passada clicando no botão "Velocidade da Animação" e selecionando a velocidade desejada.',
    'Agora vamos completar o primeiro nível do tutorial:\nPosicione o espaço de ação e ligue o "Input" com o "Output" trocando as conexões de forma necessária.',
    'Arraste o comando "Print" para o espaço de ação e passe como argumento a palava "input" (sem aspas).\nIsso fará o input ser escrito em sua saída.',
    'Se fizer corretamente, estará pronto para avançar para o próximo nível!'
    ]    
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

var arrow_sprites = ['Input', 'Output', 'ActionRect', 'DragButton', 'InputConnection', 'OutputConnection', 'ChangeInput', 
                     'ChangeOutput', 'InventoryArrow', 'ArgumentsButton', 'RunButton', 'AnimationSpeed']

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    emit_signal("hide_all")
    _hide_arrows()
    
################################################################################
#                         Text and pages Handlers                              #
################################################################################
          
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
        
################################################################################
#                           ANIMATION HANDLERS                                 #
################################################################################

#Hides all guidance arrows 
func _hide_arrows():
    for sprite in arrow_sprites:
        get_node(sprite).hide()

#Gets a node and the name of the animation,
#shows the node and play its animation.
func _animation_show_and_play(node_name, animation):
    var AnimateNode = get_node(node_name)
    AnimateNode.show()
    AnimateNode.play(animation)

#Gets a node, stops the animation and hides the node
func _animation_stop_and_hide(node_name):
    var AnimateNode = get_node(node_name)
    AnimateNode.set_frame(0)
    AnimateNode.stop()
    AnimateNode.hide()

#Shows the animations based on the actual page of dialog box    
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

#Hides all guidance arrows and the Dialog Box.
#Unpauses the game tree
func _on_Close_pressed(): 
    if page == 0 or page == 1:
        emit_signal("show_all")    
    if page == 2 or page == 3:
        emit_signal("stop_flashy", "InputFrame")
    if page == 3 or page == 4:
        emit_signal("stop_flashy", "ExpectedOutputFrame")
    if page == 4 or page == 5:
        emit_signal("stop_flashy", "PlayerOutputFrame")
    _hide_arrows()    
    $DialogBox.hide()
    get_tree().paused = false  
