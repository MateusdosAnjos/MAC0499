# TutorialGuide.gd
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)

# Variables
var dialog = [
    'Parabéns, você já aprendeu a conectar o sistema e a executá-lo.\nAgora iremos introduzir os comandos para processar os valores da entrada.',
    'Neste nível você usará o comando (ação) chamada "Print" (imprimir).\nEsse comando (ação) simplesmente pega o que está no Input (visto na animação) e escreve (imprime) em "SUA RESPOSTA".',
    'Para fazer isso você primeiro deve conectar o sistema e depois posicionar o comando "Print" como visto na imagem.\nO espaço de ação não se move caso um comando esteja posicionado.',
    'Depois clique no botão "Argumentos" e escreva "input", depois pressione "Ok".\nVocê deve conseguir um resultado parecido com o que está na imagem de exemplo.\nPassando este "argumento" o comando "Print" entenderá que deve escrever em "SUA RESPOSTA" o valor (o que está) em "Input" no momento que ele (input) passar pelo comando "Print".',
    'Clique em "Rodar" para executar seu programa e veja a animação que ajudará a entender qual o valor do Input no momento que passar pelo comando print.',
    'O próximo nível explicará mais sobre o comando print, por isso continue avançando!',
    ]    
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

#Insert the node name of poiting arrows sprites
var arrow_sprites = ['Command', 'Argument', 'RunButton']

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    get_node("Example1").hide()
    get_node("Example2").hide()
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
            _animation_show_and_play("Command", "flashy")
        2:
            _animation_stop_and_hide("Command")
            get_node("Example1").show()
        3:
            get_node("Example1").hide()
            get_node("Example2").show()
            _animation_show_and_play("Argument", "flashy")     
        4:
            get_node("Example2").hide()
            _animation_stop_and_hide("Argument")
            _animation_show_and_play("RunButton", "flashy")
        5:
            _animation_stop_and_hide("RunButton")

#Hides all guidance arrows and the Dialog Box.
#Unpauses the game tree
func _on_Close_pressed():
    _hide_arrows()
    get_node("Example1").hide()
    get_node("Example2").hide()
    $DialogBox.hide()
    get_tree().paused = false  
