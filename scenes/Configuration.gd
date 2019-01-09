extends VBoxContainer

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