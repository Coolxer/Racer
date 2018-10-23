extends Node2D

#How many times players have to drive trough track 
var rounds = 2

#How many checkpoints are on the selected track
var checkpoints = 0

var track1 = preload("res://scenes/Track.tscn")
var player1= preload("res://scenes/Car.tscn")

var GUI = preload("res://scenes/GUI.tscn")
var GUI_player = preload("res://scenes/GUIPlayer.tscn")

func _ready():
    var track = track1.instance()
    
    add_child(track)
    $Players.add_child(player1.instance())
    
    checkpoints = _get_checkpoints_count()
    
    _setup_gui()

func _process(delta):
    pass
    
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
        
func checkpoint_reached(area):
    var player = area.get_owner()
    
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
