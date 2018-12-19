extends Node2D

## Car control factors
export var max_forward_speed = 40.0
export var acceleration = 12.2

export var max_backward_speed = -5.0
# Acceleration during using brake (speed above 0)
export var brake_deceleration = -10.0
# Normal acceleration during driving back
export var drive_deceleration = -4.2

export var wheel_rotation_speed = 100
export var max_wheel_rotation_angle = 60

export var agility = 0.1

#Current friction value
var drag = 0.9
#Default friction value
export var default_drag = 0.9

#Minimum speed when velocity will be reset to 0
var min_speed = 0.1

var velocity = Vector2(0, 0)

var gas_pedal_pressed = false
var brake_pedal_pressed = false
var hand_brake_pulled = false
var turning_left = false
var turning_right = false

var min_dirt_particle_lifetime = 0.1
var max_dirt_particle_lifetime = 0.5

#Nodes
var engine
var left_dirt_emitter
var right_dirt_emitter

var left_wheel_node
var right_wheel_node

func _ready():
    engine = $Engine
    left_dirt_emitter = $LeftDirt
    right_dirt_emitter = $RightDirt
    
    left_wheel_node = $Wheels/UpperLeft
    right_wheel_node = $Wheels/UpperRight

func _process(delta):
    _input()
    
    var speed = velocity.length()
    
    if gas_pedal_pressed:    
        _accelerate(delta)
                
    if brake_pedal_pressed:
        if speed > 0:
            _decelerate(delta, drive_deceleration, 0)
        elif speed <= 0:
            _decelerate(delta, drive_deceleration, max_backward_speed)
                
    if turning_left:
        _turn_left(delta)
            
    if turning_right:
        _turn_right(delta)
      
    if !gas_pedal_pressed && !brake_pedal_pressed:
        _apply_drag(delta)
#
#    if(speed != 0):         
#        var turn_piece = current_rotation_angle * agility
#
#        current_rotation_angle -= turn_piece
#
#        if(turn_piece != 0):
#            if(speed > 0):
#                rotate(deg2rad(turn_piece))
#            else:
#                rotate(deg2rad(-turn_piece))
#
    move_and_collide(velocity)

    #Calculate direction where particles should follow
    var particles_direction = velocity.normalized().rotated(PI) * 98

    left_dirt_emitter.process_material.gravity = Vector3(particles_direction.x, particles_direction.y, 0)
    right_dirt_emitter.process_material.gravity = Vector3(particles_direction.x, particles_direction.y, 0)

    engine.pitch_scale = 0.75 + speed/max_forward_speed

    #Depending if player is moving or not emit dirt from wheels
    if speed != 0:
        _toggle_dirt(true)
    else:
        _toggle_dirt(false)
 
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

func _accelerate(delta):
    var direction = -transform.y 
            
    if velocity.length() < max_forward_speed:
        velocity += acceleration * direction * delta
        
        if velocity.length() > max_forward_speed:
            velocity = direction * max_forward_speed
            
func _decelerate(delta, deceleration, min_magnitude):
    var direction = -transform.y
    
    if velocity.length() > min_magnitude:
        velocity += deceleration * direction * delta
        
        if velocity.length() < min_magnitude:
            velocity = direction * min_magnitude
            
func _turn_left(delta): 
    var wheel_angle = left_wheel_node.rotation_degrees

    if wheel_angle > (max_wheel_rotation_angle * -1):
        wheel_angle -= wheel_rotation_speed * delta
            
        if wheel_angle < (max_wheel_rotation_angle * -1):
            wheel_angle = (max_wheel_rotation_angle * -1)
            
        _turn_wheels(wheel_angle)
        
func _turn_right(delta): 
    var wheel_angle = left_wheel_node.rotation_degrees

    if wheel_angle < max_wheel_rotation_angle:
        wheel_angle += wheel_rotation_speed * delta
            
        if wheel_angle > max_wheel_rotation_angle:
            wheel_angle = max_wheel_rotation_angle
            
        _turn_wheels(wheel_angle)
            
func _turn_wheels(angle):
    left_wheel_node.rotation_degrees = angle
    right_wheel_node.rotation_degrees = angle

func _can_wheel_rotate():
    var wheel_angle = abs(left_wheel_node.rotation_degrees - rotation_degrees)
    
    if wheel_angle < max_wheel_rotation_angle:
        return true
    return false
    
func _apply_drag(delta):
    velocity *= drag
    
    if velocity.length() <= min_speed:
        velocity = Vector2(0, 0)

func _on_Area2D_area_entered(area):
    if(area.is_in_group("grounds")):
        var track = area.get_parent()
        
        drag = track.get_friction()
   
    if(area.is_in_group("checkpoints")):
        var player = get_node("../")
        var checkpoint_index = area.get_index()
        
        get_node("/root/Game").checkpoint_reached(player, checkpoint_index)

func _on_Area2D_area_exited(area):
    if(area.is_in_group("grounds")):
        drag = default_drag
        
func _toggle_dirt(value):
    left_dirt_emitter.emitting = value
    right_dirt_emitter.emitting = value
    