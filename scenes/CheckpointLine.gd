extends Area2D

func _ready():
    #Add area to checkpoints group to be identified by car
    add_to_group("checkpoints")
