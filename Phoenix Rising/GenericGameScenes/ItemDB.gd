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
        "help": "Comando de Multiplicação.\nRecebe como argumentos dois números separados por uma vírgula e um espaço (obrigatórios) e devolve o resultado de sua multiplicação, podendo ser um número inteiro ou um número real.\nPodemos operar com o valor do input escrevendo 'input' como argumento.\nObserve os exemplos de argumentos abaixo:\n3, 4\ninput, 8\n4.2, 2\n1.2, 6.4\ninput, input\nDentre os exemplos vemos multiplicação de dois inteiros, valor de entrada e um inteiro, valor real e inteiro, dois valores reais e, por último, a multiplicação do input por ele mesmo.",
        "codePath": BEHAVIOR_PATH + "multi.gd"
    },        
    "print": {
        "icon": ICON_PATH + "print.png",
        "help": "Comando Print.\nPara imprimir o input passe como argumento a palavra 'input' (sem as aspas).\nPara exibir o que foi digitado como argumento escreva entre aspas simples (') ou duplas (\")",
        "codePath": BEHAVIOR_PATH + "print.gd"
    },
    "if/else": {
        "icon": ICON_PATH + "if_else.png",
        "help": "Comando if/else.\nEfetua comparações entre objetos do mesmo tipo, isto é, se receber um número inteiro deve fazer a comparação com um número inteiro.\nPode-se utilizar as comparações: >, <, >=, <= ou == .\nSeguem exemplos de possíveis argumentos:\n< 10\n>= 'entendido'\n<= \"duas palavras\"\n== 10.4\nOs exemplos são para comparações de inteiros, palavra, palavras e números reais respectivamente. Lembre-se que o espaço após o comparador (ex: <) é obrigatório.\nPara obter o output quando a comparação é FALSA, deve-se utilizar o output bifurcado (a comparação falsa seguirá pelo ramo de baixo), caso contrário só será aproveitado o output quando o resultado da comparação for VERDADEIRO.",
        "codePath": BEHAVIOR_PATH + "if_else.gd"
    },          
    "error": {
        "icon": ICON_PATH + "error.png",
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