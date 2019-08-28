extends Popup

func show_error_message(item):
    var teste = ItemDB.get_item(item)['help']
    $Message.set_text(teste)
    self.popup()

func _on_Understood_pressed():
    self.hide()
