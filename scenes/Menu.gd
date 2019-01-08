extends MarginContainer

func _on_Play_pressed():
    Manager.configure()

func _on_Exit_pressed():
    get_tree().quit()