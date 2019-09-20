extends Node2D

const ICON_PATH = "res://Accessories/art/"
const BEHAVIOR_PATH = "res://Behaviors/"
const ITEMS = {
    "soma": {
        "icon": ICON_PATH + "soma.png",
        "help": "Comando de Soma\nUtilizado para somar dois valores. Você pode passar como argumento dois números X, Y e o comando executa X + Y, veja o exemplo:\n4, 4\nO resultado sairá no Input (que pode ser visualizado na animação), portanto 4, 4 resultará em 8.\n\nVocê também pode operar com o valor atual do Input passando com argumento a palavra 'input' da seguinte forma:\ninput, 4\nO resultado dependerá do valor que estiver na animação.\nO comando de soma também junta (concatena) palavras da seguinte forma:\n'bolo', ' de chocolate'\nSe utilizar estes argumentos terá como resultado 'bolo de chocolate'.\n\nNão se esqueça de que devemos separar os argumentos por 1 vírgula e 1 espaço. Além disso as palavras devem ser colocadas entre aspas simples(') ou duplas(\").",
        "codePath": BEHAVIOR_PATH + "soma.gd"
    },
    "subtracao": {
        "icon": ICON_PATH + "subtracao.png",
        "help": "Comando de Subtração\nUtilizado para subtrair dois valores. Você pode passar como argumento dois números X, Y e o comando executa X - Y, veja o exemplo:\n10, 8\nO resultado sairá no Input (que pode ser visualizado na animação), portanto 10, 8 resultará em 2.\n\nVocê também pode operar com o valor atual do Input passando com argumento a palavra 'input' da seguinte forma:\ninput, 4\nO resultado dependerá do valor que estiver na animação.\n\nNão se esqueça de que devemos separar os argumentos por 1 vírgula e 1 espaço.",
        "codePath": BEHAVIOR_PATH + "subtracao.gd"
    },
    "multi": {
        "icon": ICON_PATH + "multi.png",
        "help": "Comando de Multiplicação\nUtilizado para multiplicar dois valores. Você pode passar como argumento dois números X, Y e o comando executa X * Y, veja o exemplo:\n8, 8\nO resultado sairá no Input (que pode ser visualizado na animação), portanto 8, 8 resultará em 64.\n\nVocê também pode operar com o valor atual do Input passando com argumento a palavra 'input' da seguinte forma:\ninput, 4\nO resultado dependerá do valor que estiver na animação.\n\nNão se esqueça de que devemos separar os argumentos por 1 vírgula e 1 espaço.",
        "codePath": BEHAVIOR_PATH + "multi.gd"
    },        
    "print": {
        "icon": ICON_PATH + "print.png",
        "help": "Comando Print.\nUtilizado para mostrar informações em SUA SAÍDA\nPara imprimir o input passe como argumento a palavra 'input' (sem as aspas).\nPara imprimir o conteúdo de variáveis basta passar como argumento o nome da variável, por exemplo 'A' (sem aspas). Lembre-se que há diferenciação entre letras maiúsculas e minúsculas.",
        "codePath": BEHAVIOR_PATH + "print.gd"
    },
    "if/else": {
        "icon": ICON_PATH + "if_else.png",
        "help": "Comando if/else.\nEfetua comparações entre objetos do mesmo tipo, isto é, se receber um número inteiro deve fazer a comparação com um número inteiro.\nPode-se utilizar as comparações: >, <, >=, <= ou == .\nSeguem exemplos de possíveis argumentos:\n< 10\n>= 'entendido'\n<= \"duas palavras\"\n== 10.4\nOs exemplos são para comparações de inteiros, palavra, palavras e números reais respectivamente. Lembre-se que o espaço após o comparador (ex: <) é obrigatório.\nPode-se ser utilizada uma variável como argumento.\nPara obter o output quando a comparação é FALSA, deve-se utilizar o output bifurcado (a comparação falsa seguirá pelo ramo de baixo), caso contrário só será aproveitado o output quando o resultado da comparação for VERDADEIRO.",
        "codePath": BEHAVIOR_PATH + "if_else.gd"
    },
    "A": {
        "icon": ICON_PATH + "A.png",
        "help": "Variável 'A'.\nArmazena valores e pode ser utilizado como argumento nos outros comandos do jogo.\nPara armazenar o valor do input passe como argumento a palavra 'input' (sem aspas).\nPara armazenar um inteiro passe como argumento o valor que deseja armazenar.\nPara armazenar palavra(s) o argumento deve vir entre aspas simples (') ou duplas (\").",
        "codePath": BEHAVIOR_PATH + "A.gd"
    },
    "B": {
        "icon": ICON_PATH + "B.png",
        "help": "Variável 'B'.\nArmazena valores e pode ser utilizado como argumento nos outros comandos do jogo.\nPara armazenar o valor do input passe como argumento a palavra 'input' (sem aspas).\nPara armazenar um inteiro passe como argumento o valor que deseja armazenar.\nPara armazenar palavra(s) o argumento deve vir entre aspas simples (') ou duplas (\").",
        "codePath": BEHAVIOR_PATH + "B.gd"
    },
    "pass": {
        "icon": ICON_PATH + "pass.png",
        "help": "Icone de passagem.\nServe para adicionar uma conexão sem efetuar nenhuma operação. Usado principalmente quando se deseja ignorar a sequencia de ações de um if ou um else.",
        "codePath": BEHAVIOR_PATH + "pass.gd"
    },
    "error": {
        "icon": ICON_PATH + "error.png",
        "help": "Icone de Erro.\nMostrado quando não foi possível carregar algum item do inventário.\nNão utilize este comando, verifique os arquivos do jogo e tente recarregá-lo.",
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