extends VBoxContainer

func _ready():
    $RoundsButton.add_item("1")
    $RoundsButton.add_item("2")
    $RoundsButton.add_item("3")
    $RoundsButton.add_item("4")

func _on_Back_pressed():
    Manager.load_scene(Manager.scenes["menu"])
