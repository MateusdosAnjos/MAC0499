extends Panel

func show_error_message(item, action_number):
    var teste = ItemDB.get_item(item)['help']
    $Message.set_text("Problemas com o comando " + (action_number) + ": ")
    $Message.add_text(teste)
    $Message.add_text("\nClique em 'Entendido!' para continuar")
    self.show()
    get_tree().paused = true
    return null
    
func _on_Understood_pressed():
    self.hide()
    get_tree().paused = false
