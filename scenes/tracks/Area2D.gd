extends Area2D

export var friction_factor = 0.99

func _ready():
    add_to_group("grounds")

func get_friction():
    return friction_factor