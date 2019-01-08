extends VBoxContainer

export var icons = {
    "p1": preload("res://assets/p1.png"),
    "p2": preload("res://assets/p2.png"),
    "p3": preload("res://assets/p3.png")
}

var current_player_index = 0

func _ready():
    $RoundsButton.add_item("1")
    $RoundsButton.add_item("2")
    $RoundsButton.add_item("3")
    $RoundsButton.add_item("4")

func _on_Start_pressed():
    print($RoundsButton.get_item_text($RoundsButton.selected))
    
    for track in $TracksContainer.get_children():
        if track.pressed:
            print(track.name)

func _on_Back_pressed():
    Manager.menu()

func _on_TextureButton_pressed(index):
    $CarsContainer.get_child(index).get_child(0).texture = icons["p1"]
