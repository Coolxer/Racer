extends VBoxContainer

func _on_Back_pressed():
    Manager.load_scene(Manager.scenes["menu"])
