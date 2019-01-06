extends MarginContainer

func _on_Play_pressed():
    Manager.load_scene(Manager.scenes["configuration"])

func _on_Exit_pressed():
    get_tree().quit()