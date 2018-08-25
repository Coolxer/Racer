extends Node2D

export var max_forward_speed = 20.0
export var forward_acceleration = 4.2
export var max_backward_speed = -5.0
export var backward_brake_acceleration = -10.0
export var backward_drive_acceleration = -4.2

export var max_left_wheel_rotation_angle = -40
export var max_right_wheel_rotation_angle = 40
export var wheel_rotation_speed = 100

var current_speed = 0.0
var current_rotation_angle = 0

var gas_pedal_pressed = false
var brake_pedal_pressed = false
var hand_brake_pulled = false
var turning_left = false
var turning_right = false

#Vector of car movement factor
var velocity = Vector2(0, 0)

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

func _process(delta):
    if Input.is_action_just_pressed("ui_up"):
        gas_pedal_pressed = true
    elif Input.is_action_just_released("ui_up"):
        gas_pedal_pressed = false
    
    if Input.is_action_just_pressed("ui_down"):
        brake_pedal_pressed = true
    elif Input.is_action_just_released("ui_down"):
        brake_pedal_pressed = false
    
    if Input.is_action_just_pressed("ui_left"):
        turning_left = true
    elif Input.is_action_just_released("ui_left"):
        turning_left = false
        
    if Input.is_action_just_pressed("ui_right"):
        turning_right = true
    elif Input.is_action_just_released("ui_right"):
        turning_right = false
    
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
    
    velocity.y = -current_speed
                
    position += velocity
    
    var left_wheel = $Wheels/UpperLeft
    var right_wheel = $Wheels/UpperRight
    
    if current_rotation_angle != max_left_wheel_rotation_angle and current_rotation_angle != max_right_wheel_rotation_angle:
        left_wheel.rotate(current_rotation_angle * PI/180.0 - left_wheel.transform.get_rotation())
        right_wheel.rotate(current_rotation_angle * PI/180.0 - right_wheel.transform.get_rotation())
    
    print(current_rotation_angle)
    
    pass

func get_speed():
    return velocity.length()
    
func set_speed(speed):
    var current_speed = get_speed()
    
    if current_speed != 0:
        velocity *= speed/current_speed
    else:
        velocity = Vector2(0, speed).rotated(deg2rad(rotation))
        
#speed
#acceleration
#direction
#gas
#brake
#turning
#car angle
#wheel angle
#adhesion of the surface
#grip of the wheels
#driving back