#Basic UsersGuide.gd, when creating a new level rename it to LevelxGuide.gd and attach the script
extends Control

signal frame_flashy(node_name, seconds)
signal stop_flashy(node_name)
signal hide_all()
signal show_all()

# Variables
var dialog = [
    'Insert your messages here! [color=#00007f][b] Colored too [/b][/color]',
    ]    
        
var page = 0
var max_pages = 0

onready var SkipButton = get_node("DialogBox/Skip")
onready var TextBox = get_node("DialogBox/TextBox")

# Functions        
func _ready():
    set_process_input(true)
    TextBox.set_bbcode(dialog[page])
    TextBox.set_visible_characters(0)
    emit_signal("hide_all")
    $InventoryArrow.hide()
            
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

#Use this function to manage which frames will show
func show_visuals():
    if page == 1:
        emit_signal("show_all")      

#Use this to manage when close is pressed
func _on_Close_pressed(): 
    if page == 0 or page == 1:
        emit_signal("show_all")
    self.hide()
    #Use this to unfreeze the game screen
    get_tree().paused = false  
