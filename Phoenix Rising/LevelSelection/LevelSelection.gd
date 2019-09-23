extends Control

onready var level_dict = {
    "Tutorial 1":
        ["res://Tutorial1/Tutorial1.tscn", "Este nível introduz os conceitos básicos do jogo, explica sobre como conectar os itens na tela. Perfeito para quem é iniciante."],
    "Tutorial 2":
        ["res://Tutorial2/Tutorial2.tscn", "Este nível introduz os conceitos básicos do jogo, explica sobre como modificar as conexões dos espaços de ação. Perfeito para quem é iniciante."],
    "Tutorial 3":
        ["res://Tutorial3/Tutorial3.tscn", "Este nível introduz o primeiro comando do jogo, explica como utilizá-lo e o que ele faz. Indicado somente para quem já fez e entendeu os tutoriais 1 e 2."],
    "Tutorial": 
        ["res://Tutorial/Tutorial.tscn", "Este nível introduz os conceitos básicos do jogo, explica sobre os itens na tela e como utilizá-los. Perfeito para quem é iniciante."],
    "Nível 1":  
        ["res://Level1/Level1.tscn", "Este nível introduz o operador de soma sem nenhuma entrada que auxilia o jogador."],
    "Nível 2":  
        ["res://Level2/Level2.tscn", "Este nível introduz o operador de subtração fornecendo uma entrada que auxilia o jogador."],
    "Nível 3":  
        ["res://Level3/Level3.tscn", "Este nível introduz o operador de multiplicação fornecendo uma entrada que não auxilia o jogador."],
    "Nível 4":  
        ["res://Level4/Level4.tscn", "Este nível introduz o operador de variáveis sem fornecer uma entrada para auxiliar."],
    }

func _on_level_selected(level_name):
    if level_name in level_dict:
        var level_path = (level_dict[level_name])[0]
        get_tree().change_scene(level_path)
    else:
        get_node("ErrorPopup/ErrorMessage").text = "Nível não implementado"
        get_node("ErrorPopup").popup()
        
func _on_level_description(level_name):
    if level_name in level_dict:
        var description_text = (level_dict[level_name])[1]
        var Description = get_node("DescriptionPopup/LevelDesciption")
        Description.text = description_text
        get_node("DescriptionPopup").popup()
    else:
        get_node("ErrorPopup/ErrorMessage").text = "Nível não implementado"
        get_node("ErrorPopup").popup()

func _on_ReturnToTitle_pressed():
    get_tree().change_scene("res://TitleScreen/TitleScreen.tscn")
