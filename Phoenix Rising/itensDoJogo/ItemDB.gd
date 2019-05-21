extends Node2D


const ICON_PATH = "res://acessorios/art/"
const ITEMS = {
    "godot": {
        "icon": ICON_PATH + "icon.png",
        "help": "Icone da Godot para testes"
    },
    "phoenixD": {
        "icon": ICON_PATH + "phoenix_direita.png",
        "help": "Icone da Phoenix para a direita!!"
    },
    "phoenixE": {
        "icon": ICON_PATH + "phoenix_esquerda.png",
        "help": "Icone da Phoenix para a esquerda!!"
    },         
    "error": {
        "icon": ICON_PATH + "enemyFlyingAlt_2.png",
        "help": "Icone de erro para testes"
       }
}
func get_item(item_id):
    if item_id in ITEMS:
        return ITEMS[item_id]
    else:
        return ITEMS["error"]    