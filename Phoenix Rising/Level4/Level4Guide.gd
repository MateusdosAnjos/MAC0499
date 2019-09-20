extends Control

# Variables
var dialog = [
    'Neste nível você recebeu a letra "A".\n\nEsta letra representa o comando chamado de "variável", pois servem para armazenar informações, funcionando como um apelido para diferentes valores do programa podendo ser modificadas várias vezes ao longo da execução.',
    'Portanto variáveis se assemelham a potes na culinária, pois podemos colocar o ingrediente dentro dele e utilizá-lo apenas mais tarde em nossa receita.',
    'Você pode acompanhar os valores das variáveis mudando ao longo da execução do seu programa olhando para a região "VALORES DAS VARIÁVEIS" apontada acima, isso pode ser de grande ajuda para entender um pouco mais como este comando funciona.',
    'Note que, como não foi fornecido nenhuma entrada para te ajudar, você terá que resolver o problema com as próprias mãos!\n\nPara isso clique com o botão direito do mouse sobre a variável "A" e descubra como utilizá-la.'
    ]    
        
var page = 0
var max_pages = len(dialog) - 1

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

var arrow_sprites = ['VariableA', 'VariableValues']

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    _hide_arrows()
    _animation_show_and_play("VariableA", "flashy")
    
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
            _animation_stop_and_hide("VariableA")
        2:
            _animation_show_and_play("VariableValues", "flashy")
        3:
            _animation_stop_and_hide("VariableValues")

#Hides all guidance arrows and the Dialog Box.
#Unpauses the game tree
func _on_Close_pressed():  
    _hide_arrows()    
    $DialogBox.hide()
    get_tree().paused = false  
