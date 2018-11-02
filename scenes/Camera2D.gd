extends Camera2D

export var camera_speed = 300.0

const NORMALIZATION_FACTOR = 400.0

func _ready():
    make_current()

func _process(delta):
    _follow_players(delta)

func _follow_players(delta):
    var players = get_node("/root/Game/Players").get_children()
    
    var cars = []
    
    for player in players:
        cars.append(player.get_child(0))
    
    var difference = _get_average_position(cars) - position
    var camera_offset = difference.normalized() * camera_speed * delta
    
    var distance = _get_largest_distance(cars)
    var distance_normalized = distance / NORMALIZATION_FACTOR
    
    if distance_normalized < 1:
        distance_normalized = 1
    
    zoom = Vector2(distance_normalized, distance_normalized)
    
    if(difference.length() >= camera_offset.length()):
        position += camera_offset

func _get_average_position(nodes):    
    var nodes_count = nodes.size()
    var positions_sum = Vector2(0, 0)
    
    for node in nodes:        
        positions_sum += node.position
        
    var average_position = positions_sum / nodes_count
    
    return average_position
    
func _get_largest_distance(nodes):
    var min_x = 0
    var min_y = 0
    var max_x = 0
    var max_y = 0
    
    min_x = nodes[0].position.x
    min_y = nodes[0].position.y
    max_x = nodes[0].position.x
    max_y = nodes[0].position.y
    
    nodes.pop_front()
    
    for node in nodes:
        if node.position.x < min_x:
            min_x = node.position.x
        
        if node.position.y < min_y:
            min_y = node.position.y
        
        if node.position.x > max_x:
            max_x = node.position.x
        
        if node.position.y > max_y:
            max_y = node.position.y
       
    var delta_x = max_x - min_x
    var delta_y = max_y - min_y
         
    if delta_x > delta_y:
        return delta_x
    return delta_y
        