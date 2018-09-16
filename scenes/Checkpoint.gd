extends Node2D

func _ready():
    add_to_group("checkpoints")

func _on_Area2D_area_entered(area):
    var game_obj = get_node("/root/Game")
    
    game_obj.checkpoint_reached(area)
