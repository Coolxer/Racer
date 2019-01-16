extends Node2D

#How many times players have to drive trough track 
var rounds = 1

#How many checkpoints are on the selected track
var checkpoints = 0

var player_scene = preload("res://scenes/Player.tscn")

var GUI_scene = preload("res://scenes/GUI.tscn")
var GUI_player_scene = preload("res://scenes/GUIPlayer.tscn")

#GUI node containing all players
var GUI_players_node

var GUI_timer_node

var track_node

func _ready():
    _setup_track()
    _setup_players()
    
    rounds = Manager.round_amount
    
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
    
func _setup_track():
    if Manager.track_scene != null:
        track_node = Manager.track_scene.instance()
    
    add_child(track_node)
    
func _setup_players():
    var player_index = 0
    
    for car_scene in Manager.car_scenes:
        var player_node = player_scene.instance()
        var car_node = car_scene.instance()
        
        var spawnpoint = get_node("Track/Spawnpoints").get_child(player_index)
        
        car_node.position = spawnpoint.position
        car_node.rotation = spawnpoint.rotation
        
        player_node.add_child(car_node)
        
        var keys = Manager.keys[player_index]
        
        player_node.gas_pedal_key = keys["up"]
        player_node.brake_pedal_key = keys["down"]
        player_node.turn_left_key = keys["left"]
        player_node.turn_right_key = keys["right"]
    
        $Players.add_child(player_node)
        
        player_index += 1
        
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
    
                if(current_round == rounds):
                    player.finish()
                else:
                    current_checkpoint = 0
                    
                player.set_current_round(current_round)
                player.GUI_player_node.set_round(current_round, rounds)
                
            player.set_current_checkpoint(current_checkpoint)
            player.GUI_player_node.set_checkpoint(current_checkpoint, checkpoints)
            
            #After someone of players reached next checkpoint/round update ranking
            GUI_players_node.update_order()
