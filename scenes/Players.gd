extends VBoxContainer

var player_nodes = []

func register_player(player_node):
    player_nodes.append(player_node)
    add_child(player_node.GUI_player_node)

func update_order():
    player_nodes.sort_custom(self, "_sort_players")
    
    var index = 0
    for player_node in player_nodes:
        move_child(player_node.GUI_player_node, index)
        player_node.GUI_player_node.update_position()
        index += 1 
          
func _sort_players(player_1, player_2):
    if ((player_1.current_round <= player_2.current_round) && (player_1.current_checkpoint < player_2.current_checkpoint)):
        return false
    return true