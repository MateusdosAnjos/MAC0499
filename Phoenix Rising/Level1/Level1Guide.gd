extends Control

# Variables
var dialog = [
    'Agora produza o resultado esperado a partir de nenhuma entrada (input), simbolizada com "-".\n\nIsso significa que você não recebe nenhum ingrediente.',
    'Para obter seu "bolo" (a resposta esperada) utilize o comando de soma "+" disponibilizado e crie a resposta.\n\nPressione o botão direito em cima do comando de soma para obter ajuda sobre como utilizá-lo.',
    'Não se esqueca de colocar o comando "Print" para imprimir o input (sua resposta) na sua saída.'
    ]    
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

#Insert the node name of poiting arrows sprites
var arrow_sprites = ["NoInput", "SumCommand"]

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    _hide_arrows()
    _animation_show_and_play("NoInput", "flashy")
    
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
            _animation_stop_and_hide("NoInput")
            _animation_show_and_play("SumCommand", "flashy")
        2:
            _animation_stop_and_hide("SumCommand")

#Hides all guidance arrows and the Dialog Box.
#Unpauses the game tree
func _on_Close_pressed():
    _hide_arrows()
    $DialogBox.hide()
    get_tree().paused = false  
