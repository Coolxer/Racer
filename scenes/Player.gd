extends Node2D

export var nickname = "Player"

## Key names to control car movement
export var gas_pedal_key = ""
export var brake_pedal_key = ""
export var turn_left_key = ""
export var turn_right_key = ""

var current_checkpoint = 0
var current_round = 0
var finished = false

var interface_ref = null

func get_nickname():
    return nickname
    
func get_current_checkpoint():
    return current_checkpoint
    
func set_current_checkpoint(checkpoint):
    current_checkpoint = checkpoint
    
func get_current_round():
    return current_round
    
func set_current_round(cround):
    current_round = cround
    
func get_interface_ref():
    return interface_ref
    
func set_interface_ref(interface):
    interface_ref = interface
    
func finish():
    finished = true
    
func is_finished():
    return finished