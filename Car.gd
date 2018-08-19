extends Node2D

export var max_speed = 40;
export var acceleration = 8.2;

export var max_wheel_rotation_angle = 60;

var current_speed = 0.0

var gas_pedal_pressed = false
var brake_pedal_pressed = false
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
    
    var current_speed = get_speed()
    
    if gas_pedal_pressed:    
        if current_speed < max_speed:
            current_speed += acceleration * delta
        
            if current_speed > max_speed:
                current_speed = max_speed
                
    set_speed(current_speed)
                
    position += velocity
    
    pass

func get_speed():
    return velocity.length()
    
func set_speed(speed):
    var current_speed = get_speed()
    
    if current_speed != 0:
        velocity *= speed/get_speed()
    else
        velocity = Vector2()
        
#speed
#direction
#gas
#brake
#turning
#acceleration
#car angle
#wheel angle
#adhesion of the surface
#grip of the wheels
#driving back