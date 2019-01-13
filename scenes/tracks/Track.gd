extends Node2D

export var friction_factor = 0.99

func _ready():
    $Area2D.add_to_group("grounds")

func get_friction():
    return friction_factor
