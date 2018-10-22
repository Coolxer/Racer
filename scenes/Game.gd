extends Node2D

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
        
        get_node("CanvasLayer/GUI/Players").add_child(player_interface)
        
func checkpoint_reached(area):
    print(area.get_owner())