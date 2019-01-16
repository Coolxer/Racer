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

var GUI_player_node = null

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
    
func finish():
    finished = true
    
    GUI_player_node.change_color(Color(120/255.0, 230/255.0, 68/255.0))
    
func is_finished():
    return finished