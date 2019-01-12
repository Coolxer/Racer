extends VBoxContainer

var current_player_index = 0

func _ready():
    $RoundsButton.add_item("1")
    $RoundsButton.add_item("2")
    $RoundsButton.add_item("3")
    $RoundsButton.add_item("4")

func _on_Start_pressed():    
    var rounds = int($RoundsButton.get_item_text($RoundsButton.selected))
    Manager.game($TracksContainer.selected, $CarsContainer.players, rounds)

func _on_Back_pressed():
    Manager.menu()