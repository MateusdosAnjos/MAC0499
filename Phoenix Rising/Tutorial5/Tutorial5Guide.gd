# TutorialGuide.gd
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)

# Variables
var dialog = [
    'Parabéns, você já aprendeu o básico do jogo e está pronto(a) para avançar ainda mais!',
    'Agora vamos introduzir o comando de soma, sinalizado pela seta.\nEste comando recebe como argumento x, y e tem como resposta x+y.\nNão se preocupe, tudo ficará mais claro com o exemplo.',
    'Primeiro você deve conectar o sistema, esta parte deixaremos como um pequeno desafio.',
    'Depois preencha os "Argumentos" do comando soma como indicado no exemplo.\nIsso fará com que o comando soma pegue o valor atual do Input e some com o número 1 e então o comando substituirá o Input antigo pela resposta que ele (comando soma) obteve (preste atenção na animação).',
    'Depois basta utilizar o comando "Print" como foi ensinado anteriormente.'
    ]
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

#Insert the node name of poiting arrows sprites
var arrow_sprites = ["SumCommand"]

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    _hide_arrows()
    get_node("Example").hide()
    
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
            _animation_show_and_play("SumCommand", "flashy")
        2:
            _animation_stop_and_hide("SumCommand")
        3:
            get_node("Example").show()
        4:
            get_node("Example").hide()

#Hides all guidance arrows and the Dialog Box.
#Unpauses the game tree
func _on_Close_pressed():
    _hide_arrows()
    get_node("Example").hide()
    $DialogBox.hide()
    get_tree().paused = false  
