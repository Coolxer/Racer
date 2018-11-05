extends Node2D

## Car control factors
export var max_forward_speed = 40.0
export var forward_acceleration = 12.2
export var max_backward_speed = -5.0
# Acceleration during using brake (speed above 0)
export var backward_brake_acceleration = -10.0
# Normal acceleration during driving back
export var backward_drive_acceleration = -4.2

export var max_left_wheel_rotation_angle = -40
export var max_right_wheel_rotation_angle = 40
export var wheel_rotation_speed = 100

export var agility = 0.1

export var default_ground_friction_factor = 0.9

var current_speed = 0.0
var current_rotation_angle = 0.0

var ground_friction_factor = 0.9

var gas_pedal_pressed = false
var brake_pedal_pressed = false
var hand_brake_pulled = false
var turning_left = false
var turning_right = false

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

func _process(delta):
    _input()
    
    if gas_pedal_pressed:    
        if current_speed < max_forward_speed:
            current_speed += forward_acceleration * delta
        
            if current_speed > max_forward_speed:
                current_speed = max_forward_speed
                
    if brake_pedal_pressed:
        if current_speed > 0:
            current_speed += backward_brake_acceleration * delta
        elif current_speed > max_backward_speed:
            current_speed += backward_drive_acceleration * delta
            
            if current_speed < max_backward_speed:
                current_speed = max_backward_speed
                
    current_speed *= ground_friction_factor
                
    if turning_left:
        if current_rotation_angle > max_left_wheel_rotation_angle:
            current_rotation_angle -= wheel_rotation_speed * delta
            
            if current_rotation_angle < max_left_wheel_rotation_angle:
                current_rotation_angle = max_left_wheel_rotation_angle
            
    if turning_right:
        if current_rotation_angle < max_right_wheel_rotation_angle:
            current_rotation_angle += wheel_rotation_speed * delta
    
            if current_rotation_angle > max_right_wheel_rotation_angle:
                current_rotation_angle = max_right_wheel_rotation_angle
    
    #Vector of car movement factor
    var velocity = Vector2(0, 0)
    velocity.y = -current_speed
    velocity = velocity.rotated(rotation)
       
    if(current_speed != 0):         
        var turn_piece = current_rotation_angle * agility
        
        current_rotation_angle -= turn_piece
                       
        if(turn_piece != 0):
            if(current_speed > 0):
                rotate(deg2rad(turn_piece))
            else:
                rotate(deg2rad(-turn_piece))
                
    position += velocity
    
    var left_wheel = $Wheels/UpperLeft
    var right_wheel = $Wheels/UpperRight
    
    if current_rotation_angle != max_left_wheel_rotation_angle and current_rotation_angle != max_right_wheel_rotation_angle:
        left_wheel.rotate(current_rotation_angle * PI/180.0 - left_wheel.transform.get_rotation())
        right_wheel.rotate(current_rotation_angle * PI/180.0 - right_wheel.transform.get_rotation())
    
    #Calculate direction where particles should follow
    var particles_direction = velocity.normalized().rotated(PI) * 98
    
    $LeftDirt.process_material.gravity = Vector3(particles_direction.x, particles_direction.y, 0)
    $RightDirt.process_material.gravity = Vector3(particles_direction.x, particles_direction.y, 0)
    
    $Engine.pitch_scale = 0.75 + current_speed/max_forward_speed
 
# Manage user input  
func _input():
    var player = get_node("../")
    
    if Input.is_action_just_pressed(player.gas_pedal_key):
        gas_pedal_pressed = true
    elif Input.is_action_just_released(player.gas_pedal_key):
        gas_pedal_pressed = false
    
    if Input.is_action_just_pressed(player.brake_pedal_key):
        brake_pedal_pressed = true
    elif Input.is_action_just_released(player.brake_pedal_key):
        brake_pedal_pressed = false
    
    if Input.is_action_just_pressed(player.turn_left_key):
        turning_left = true
    elif Input.is_action_just_released(player.turn_left_key):
        turning_left = false
        
    if Input.is_action_just_pressed(player.turn_right_key):
        turning_right = true
    elif Input.is_action_just_released(player.turn_right_key):
        turning_right = false

func _on_Area2D_area_entered(area):
    if(area.is_in_group("grounds")):
        var track = area.get_parent()
        
        ground_friction_factor = track.get_friction()
   
    if(area.is_in_group("checkpoints")):
        var player = get_node("../")
        
        get_node("/root/Game").checkpoint_reached(player)

func _on_Area2D_area_exited(area):
    if(area.is_in_group("grounds")):
        ground_friction_factor = default_ground_friction_factor
        