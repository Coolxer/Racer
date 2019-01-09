extends HBoxContainer

export var icons = [
    preload("res://assets/p1.png"),
    preload("res://assets/p2.png"),
    preload("res://assets/p3.png")
]

var players = []
var max_players = 3

func _on_Car_pressed(index):
    var option = get_child(index)
    
    if _can_add_player(option):
        _select_player(option)
    else:
        _unselect_player(option)

func _can_add_player(option):
    if option.get_node("TextureButton").pressed && players.size() < max_players:
        return true
    return false
       
func _select_player(option):
    option.get_node("TextureRect").texture = icons[players.size()]
    players.append(option.name)
    
func _unselect_player(option):
     option.get_node("TextureRect").texture = null
     players.pop_back()