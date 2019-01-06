extends StaticBody2D

var sound_on_collision_node

func _ready():
    sound_on_collision_node = $AudioStreamPlayer2D

func collide():
    sound_on_collision_node.play()
