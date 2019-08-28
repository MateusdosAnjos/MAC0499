extends Node2D

const ICON_PATH = "res://Accessories/art/"
const BEHAVIOR_PATH = "res://Behaviors/"
const ITEMS = {
    "soma": {
        "icon": ICON_PATH + "soma.png",
        "help": "Icone de soma",
        "codePath": BEHAVIOR_PATH + "soma.gd"
    },
    "subtracao": {
        "icon": ICON_PATH + "subtracao.png",
        "help": "Icone de subtração",
        "codePath": BEHAVIOR_PATH + "subtracao.gd"
    },
    "multi": {
        "icon": ICON_PATH + "multi.png",
        "help": "Icone de multiplicação",
        "codePath": BEHAVIOR_PATH + "multi.gd"
    },        
    "print": {
        "icon": ICON_PATH + "print.png",
        "help": "Icone do comando Print.\nPara imprimir o input passe como argumento a palavra 'input' (sem as aspas).\nPara exibir o que foi digitado como argumento escreva entre aspas simples (') ou duplas (\")",
        "codePath": BEHAVIOR_PATH + "print.gd"
    },
    "if/else": {
        "icon": ICON_PATH + "if_else.png",
        "help": "Icone do comando if/else",
        "codePath": BEHAVIOR_PATH + "if_else.gd"
    },          
    "error": {
        "icon": ICON_PATH + "enemyFlyingAlt_2.png",
        "help": "Icone de erro para testes",
        "codePath": BEHAVIOR_PATH + "error.gd"
       }
}

#Used to search in data base for corresponding item using
#item_id
func get_item(item_id):
    if item_id in ITEMS:
        return ITEMS[item_id]
    else:
        return ITEMS["error"]    