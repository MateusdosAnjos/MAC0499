# TutorialGuide.gd
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)

# Variables
var dialog = [
    'Bem vindo ao Phoenix Rising!\n\nEste jogo é uma maneira lúdica de introduzir conceitos de programação!\nPortanto em cada nível você criará um pequeno programa que soluciona o problema do nível.',
    'Este nível irá ensinar como começar a jogar.\n\nPrimeiro você deve resolver uma espécie de quebra-cabeças, encaixando as peças para que seja possível executar (rodar) seu programa.',
    'Primeiro você deve conectar a "Entrada" com a "Saída" para que seja possível executar o programa. Quando conectados elas ficarão verdes.',
    'Para conectá-las clique e segure na mãozinha do item "espaço de ação" e o arraste até ficar como o exemplo mostrado na tela.',
    'Após conectar a "Entrada" com a "Saída" clique no botão "Rodar!"',
    'Feito isso, espere a animação acabar e estará pronto para o próximo nível clicando no botão que aparecerá onde a seta está indicando!'
    ]    
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

#Insert the node name of poiting arrows sprites
var arrow_sprites = ['Input', 'Output', 'DragButton', 'RunButton', 'NextLevel']

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    get_node("Example").hide()
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
        2:
            _animation_show_and_play("Input", "flashy")
            _animation_show_and_play("Output", "flashy")
        3:
            _animation_stop_and_hide("Input")
            _animation_stop_and_hide("Output")
            _animation_show_and_play("DragButton", "flashy")
            get_node("Example").show()
        4:
            _animation_stop_and_hide("DragButton")
            get_node("Example").hide()
            _animation_show_and_play("RunButton", "flashy")
        5:
            _animation_stop_and_hide("RunButton")
            _animation_show_and_play("NextLevel", "flashy")

#Hides all guidance arrows and the Dialog Box.
#Unpauses the game tree
func _on_Close_pressed():
    _hide_arrows()
    get_node("Example").hide()
    $DialogBox.hide()
    get_tree().paused = false  
