extends Node2D

export var damp = 3.0

func _ready():
    $Area2D.add_to_group("grounds")
