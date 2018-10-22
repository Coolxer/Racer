extends Node2D

#How many times players have to drive trough track 
export var rounds = 2

var track1 = preload("res://scenes/Track.tscn")
var player1= preload("res://scenes/Car.tscn")

var GUI = preload("res://scenes/GUI.tscn")
var GUI_player = preload("res://scenes/GUIPlayer.tscn")

func _ready():
    add_child(track1.instance())
    $Players.add_child(player1.instance())
    
    _setup_gui()

func _process(delta):
    pass
    
func _setup_gui():
    $CanvasLayer.add_child(GUI.instance())
    
    for player in $Players.get_children():
        var player_interface = GUI_player.instance()
        
        player_interface.set_nickname(player.get_nickname())
        player_interface.set_round(0, 2)
        
        var checkpoint_count = get_node("Track/Checkpoints").get_child_count()
        player_interface.set_checkpoint(0, checkpoint_count)
        
        get_node("CanvasLayer/GUI/Players").add_child(player_interface)
        
func checkpoint_reached(area):
    print(area.get_owner())