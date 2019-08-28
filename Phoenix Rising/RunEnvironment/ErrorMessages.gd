extends Popup

func show_error_message(item, action_number):
    var teste = ItemDB.get_item(item)['help']
    $Message.set_text("Problemas com o comando " + (action_number) + ": ")
    $Message.add_text(teste)
    self.popup()

func _on_Understood_pressed():
    self.hide()
