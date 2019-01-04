extends RigidBody2D

export var acceleration = 1000.0
export var deceleration = -300.0

export var turn_speed = 8000

var stop_acceleration = false
var stop_deceleration = false
var stop_turning_left = false
var stop_turning_right = false

var player_node = null

func _ready():
    player_node = get_node("../")
    
func _input(event):
    if event is InputEventKey:
        if event.is_action_released(player_node.gas_pedal_key):
            stop_acceleration = true
            
        if event.is_action_released(player_node.brake_pedal_key):
            stop_deceleration = true
            
        if event.is_action_released(player_node.turn_left_key):
            stop_turning_left = true
            
        if event.is_action_released(player_node.turn_right_key):
            stop_turning_right = true
      
func _integrate_forces(state):
    if Input.is_action_pressed(player_node.gas_pedal_key):
        set_applied_force(Vector2(0, -1).rotated(rotation) * acceleration)
    if stop_acceleration:
        set_applied_force(Vector2())
        stop_acceleration = false
        
    if Input.is_action_pressed(player_node.brake_pedal_key):
        set_applied_force(Vector2(0, -1).rotated(rotation) * deceleration)
    if stop_deceleration:
        set_applied_force(Vector2())   
        stop_deceleration = false  
    
    if Input.is_action_just_pressed(player_node.turn_left_key):
        if get_linear_velocity().length() != 0:
            set_applied_torque(-turn_speed)
    if stop_turning_left:
        set_applied_torque(0)
        stop_turning_left = false
        
    if Input.is_action_just_pressed(player_node.turn_right_key):
        if get_linear_velocity().length() != 0:
            set_applied_torque(turn_speed)
    if stop_turning_right:
        set_applied_torque(0)
        stop_turning_right = false