# TutorialGuide.gd
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)

# Variables
var dialog = [
    'Parabéns, você já aprendeu a conectar o sistema e a executá-lo utilizando o primeiro comando chamado "Print".\nAgora explicaremos melhor quais são seus objetivos.',
    'Em cada nível serão oferecidos a você valores de ENTRADA.\nNeste nível foram fornecidos os valores de 1 a 8, como você pode ver na região que está piscando.\nCada vez que seu programa for executado os valores que estão separados por vírgulas serão fornecidos um a um.\nA animação deixará tudo mais claro.',
    'Seu objetivo é conseguir que "Sua Resposta" seja igual a "Resposta Esperada" (fizemos isso nos níveis anteriores).\nPara isso você deve criar um programa que processe os dados da Entrada de forma a conseguir a Resposta esperada.',
    'Ao conseguir concluir o nível sua resposta ficará cercada de um retângulo verde e você poderá avançar para o próximo nível.',
    'Neste nível você deve efetuar o mesmo que fez no nível anterior e prestar bastante atenção na animação, para perceber como os valores da entrada são consumidos e como o valor Input é modificado.'
    ]    
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

#Insert the node name of poiting arrows sprites
var arrow_sprites = []

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
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
            emit_signal("frame_flashy", "InputFrame", 0)
        2:
            emit_signal("stop_flashy", "InputFrame")
            emit_signal("frame_flashy", "ExpectedOutputFrame", 0)
            emit_signal("frame_flashy", "PlayerOutputFrame", 0)
        3:
            emit_signal("stop_flashy", "ExpectedOutputFrame")
            get_parent().get_node("ColoredFrames/PlayerOutputFrame").set_animation("success_flashy")
        4:
            get_parent().get_node("ColoredFrames/PlayerOutputFrame").set_animation("flashy")
            emit_signal("stop_flashy", "PlayerOutputFrame")

#Hides all guidance arrows and the Dialog Box.
#Unpauses the game tree
func _on_Close_pressed():
    _hide_arrows()
    get_parent().get_node("ColoredFrames/PlayerOutputFrame").set_animation("flashy")
    emit_signal("stop_flashy", "PlayerOutputFrame")
    emit_signal("stop_flashy", "ExpectedOutputFrame")
    emit_signal("stop_flashy", "InputFrame")
    $DialogBox.hide()
    get_tree().paused = false  
