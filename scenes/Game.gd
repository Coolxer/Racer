extends Node2D

#How many times players have to drive trough track 
var rounds = 2

#How many checkpoints are on the selected track
var checkpoints = 0

var track_scene_1 = preload("res://scenes/tracks/Track1.tscn")
var track_scene_2 = preload("res://scenes/tracks/Track2.tscn")

var car_scene_1 = preload("res://scenes/cars/Car1.tscn")
var car_scene_2 = preload("res://scenes/cars/Car2.tscn")

var player_scene = preload("res://scenes/Player.tscn")

var GUI_scene = preload("res://scenes/GUI.tscn")
var GUI_player_scene = preload("res://scenes/GUIPlayer.tscn")

#GUI node containing all players
var GUI_players_node

var GUI_timer_node

func _ready():
    var track = track_scene_2.instance()
    
    add_child(track)
    
    var player1 = player_scene.instance()
    var car1 = car_scene_1.instance()
    
    var spawnpoint1 = get_node("Track/Spawnpoints").get_child(0)
    car1.position = spawnpoint1.position
    car1.rotation = spawnpoint1.rotation
    
    player1.add_child(car1)
    
    player1.gas_pedal_key = "up_1"
    player1.brake_pedal_key = "down_1"
    player1.turn_left_key = "left_1"
    player1.turn_right_key = "right_1"
    
    $Players.add_child(player1)
    
    var player2 = player_scene.instance()
    var car2 = car_scene_2.instance()
    
    var spawnpoint2 = get_node("Track/Spawnpoints").get_child(1)
    car2.position = spawnpoint2.position
    car2.rotation = spawnpoint2.rotation
    
    player2.add_child(car2)
    
    player2.gas_pedal_key = "up_2"
    player2.brake_pedal_key = "down_2"
    player2.turn_left_key = "left_2"
    player2.turn_right_key = "right_2"
    
    $Players.add_child(player2)
    
    checkpoints = _get_checkpoints_count()
    
    _setup_gui()
    
func _process(delta):
    GUI_timer_node.update()
  
#Instance main gui and fill with choosen players  
func _setup_gui():
    $CanvasLayer.add_child(GUI_scene.instance())
    
    GUI_players_node = get_node("CanvasLayer/GUI/Players")
    GUI_timer_node = get_node("CanvasLayer/GUI/VBoxContainer/Timer")
    
    GUI_timer_node.start()
    
    for player in $Players.get_children():
        var GUI_player_node = GUI_player_scene.instance()
        
        #Set reference for player to it's GUI part
        player.GUI_player_node = GUI_player_node
        
        GUI_player_node.set_nickname(player.get_nickname())
        GUI_player_node.set_round(0, rounds)        
        GUI_player_node.set_checkpoint(0, checkpoints)
        
        GUI_players_node.register_player(player)

func _get_checkpoints_count():
    return get_node("Track/Checkpoints").get_child_count()
        
func checkpoint_reached(player, checkpoint_index):    
    if(!player.is_finished()):
        var current_checkpoint = player.get_current_checkpoint()
        
        #Check checkpoint index undex track checkpoints parent
        #to know which in order this checkpoints is
        #and pass only when index is only bigger by value of 1
        #this will force to passing checkpoints one by one
        #by their node order in Checkpoint node of Track node
        if (checkpoint_index + 1) - current_checkpoint == 1:
            current_checkpoint += 1
            
            if(current_checkpoint == checkpoints):
                var current_round = player.get_current_round()
                
                current_round += 1
    
                if(current_round > rounds):
                    player.finish()
                else:
                    current_checkpoint = 0
                    player.set_current_round(current_round)
                    player.GUI_player_node.set_round(current_round, rounds)
                
            player.set_current_checkpoint(current_checkpoint)
            player.GUI_player_node.set_checkpoint(current_checkpoint, checkpoints)
            
            #After someone of players reached next checkpoint/round update ranking
            GUI_players_node.update_order()
