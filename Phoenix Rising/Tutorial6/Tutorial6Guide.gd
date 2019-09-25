# TutorialGuide.gd
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)

# Variables
var dialog = [
    'Agora que você já aprendeu como escrever sua resposta com o comando print e como efetuar as operações básicas podemos avançar ainda mais introduzindo o conceito de VARIÁVEIS.',
    'Você recebeu a letra "A" indicada pela seta.\nEsta é a variável "A" e serve para armazenar algum valor do seu programa que você queira utilizar futuramente.',
    'O nome é "variável", pois o valor de "A" pode mudar durante a execução do programa.\nPara facilitar o entendimento você pode acompanhar o valor da variável "A" em cada ciclo do programa olhando para a área "VALORES DAS VARIÁVEIS" indicada pela seta',
    'Como você não recebe nenhum elemento input na ENTRADA será necessário atribuir um "valor" para a variável A.\nPasse a frase como argumento para a variável A como indicado no exemplo 1.',
    'Depois você deve passar o nome da variável para o comando print, como aparece no exemplo 2.',
    ]
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

#Insert the node name of poiting arrows sprites
var arrow_sprites = ["VariableA", "VariablesValues"]

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    _hide_arrows()
    get_node("Example1").hide()
    get_node("Example2").hide()
    
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
            _animation_show_and_play("VariableA", "flashy")
        2:
            _animation_stop_and_hide("VariableA")
            _animation_show_and_play("VariablesValues", "flashy")
        3:
            _animation_stop_and_hide("VariablesValues")
            get_node("Example1").show()
        4:
            get_node("Example1").hide()
            get_node("Example2").show()

#Hides all guidance arrows and the Dialog Box.
#Unpauses the game tree
func _on_Close_pressed():
    _hide_arrows()
    get_node("Example1").hide()
    get_node("Example2").hide()
    $DialogBox.hide()
    get_tree().paused = false  
