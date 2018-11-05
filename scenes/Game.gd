extends Node2D

#How many times players have to drive trough track 
var rounds = 2

#How many checkpoints are on the selected track
var checkpoints = 0

var track1 = preload("res://scenes/tracks/Track1.tscn")
var track2 = preload("res://scenes/tracks/Track2.tscn")

var car1 = preload("res://scenes/cars/Car1.tscn")
var car2 = preload("res://scenes/cars/Car2.tscn")

var player= preload("res://scenes/Player.tscn")

var GUI = preload("res://scenes/GUI.tscn")
var GUI_player = preload("res://scenes/GUIPlayer.tscn")

func _ready():
    var track = track2.instance()
    
    add_child(track)
    
    var player1 = player.instance()
    player1.add_child(car1.instance())
    
    player1.gas_pedal_key = "up_1"
    player1.brake_pedal_key = "down_1"
    player1.turn_left_key = "left_1"
    player1.turn_right_key = "right_1"
    
    $Players.add_child(player1)
    
    var player2 = player.instance()
    player2.add_child(car2.instance())
    
    player2.gas_pedal_key = "up_2"
    player2.brake_pedal_key = "down_2"
    player2.turn_left_key = "left_2"
    player2.turn_right_key = "right_2"
    
    $Players.add_child(player2)
    
    checkpoints = _get_checkpoints_count()
    
    _setup_gui()
    
func _setup_gui():
    $CanvasLayer.add_child(GUI.instance())
    
    for player in $Players.get_children():
        var player_interface = GUI_player.instance()
        
        player.set_interface_ref(player_interface)
        
        player_interface.set_nickname(player.get_nickname())
        player_interface.set_round(0, rounds)
        
        player_interface.set_checkpoint(0, checkpoints)
        
        get_node("CanvasLayer/GUI/Players").add_child(player_interface)

func _get_checkpoints_count():
    return get_node("Track/Checkpoints").get_child_count()
        
func checkpoint_reached(player):    
    if(!player.is_finished()):
        var current_checkpoint = player.get_current_checkpoint()
        
        current_checkpoint += 1
        
        if(current_checkpoint == checkpoints):
            var current_round = player.get_current_round()
            
            current_round += 1

            if(current_round > rounds):
                player.finish()
            else:
                current_checkpoint = 0
                player.set_current_round(current_round)
                player.get_interface_ref().set_round(current_round, rounds)
            
        player.set_current_checkpoint(current_checkpoint)
        player.get_interface_ref().set_checkpoint(current_checkpoint, checkpoints)
