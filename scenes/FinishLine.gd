extends Node2D

func _ready():
    #Add area to finishes group to be identified by car
    $Area2D.add_to_group("finishes")
