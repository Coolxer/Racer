extends Container

var scoreboard_player_scene = preload("res://scenes/ScoreboardPlayer.tscn")

func add_player(position, nickname):
    var scoreboard_player_node = scoreboard_player_scene.instance()
    scoreboard_player_node.get_node("Position").text = "#" + str(position)
    scoreboard_player_node.get_node("Nickname").text = nickname
    
    $VBoxContainer.add_child(scoreboard_player_node)