extends Node2D

func _ready():
    #Add area to checkpoints group to be identified by car
    $Area2D.add_to_group("checkpoints")
