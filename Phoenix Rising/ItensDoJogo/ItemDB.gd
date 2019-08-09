extends Node2D

const ICON_PATH = "res://Acessorios/art/"
const BEHAVIOR_PATH = "res://Comportamentos/"
const ITEMS = {
    "godot": {
        "icon": ICON_PATH + "icon.png",
        "help": "Icone da Godot para testes",
        "codePath": BEHAVIOR_PATH + "godot.gd"
    },
    "print": {
        "icon": ICON_PATH + "print.png",
        "help": "Icone do comando Print",
        "codePath": BEHAVIOR_PATH + "print.gd"
    },
    "phoenixE": {
        "icon": ICON_PATH + "phoenix_esquerda.png",
        "help": "Icone da Phoenix para a esquerda!!",
        "codePath": BEHAVIOR_PATH + "phoenixE.gd"
    },         
    "error": {
        "icon": ICON_PATH + "enemyFlyingAlt_2.png",
        "help": "Icone de erro para testes",
        "codePath": BEHAVIOR_PATH + "error.gd"
       }
}
func get_item(item_id):
    if item_id in ITEMS:
        return ITEMS[item_id]
    else:
        return ITEMS["error"]    