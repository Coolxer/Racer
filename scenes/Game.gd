extends Node2D

var track1 = preload("res://scenes/Track.tscn")
var player1= preload("res://scenes/Car.tscn")

func _ready():
    add_child(track1.instance())
    $Players.add_child(player1.instance())

func _process(delta):
    pass
        
func checkpoint_reached(area):
    print(area.get_owner())