extends Control

# Variables
var dialog = [
    'Neste nível você recebeu o comando "A".\n"A" é uma variável e serve para armazenar informações.',
    'Como não foi fornecido nenhuma entrada para te ajudar você terá que resolver o problema com as próprias mãos!'
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
    else:
        TextBox.set_visible_characters(TextBox.get_total_character_count())
   
#Use this to manage when close is pressed
func _on_Close_pressed(): 
    self.hide()
    #Use this to unfreeze the game screen
    get_tree().paused = false  
