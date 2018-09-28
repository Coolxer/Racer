extends Camera2D

export var camera_speed = 300.0

func _ready():
    make_current()

func _process(delta):
    _follow_players(delta)

func _follow_players(delta):
    var difference = _get_center_players_position() - position
    var camera_offset = difference.normalized() * camera_speed * delta
    
    if(difference.length() >= camera_offset.length()):
        position += camera_offset

func _get_center_players_position():
    var min_x = 0
    var max_x = 0
    var min_y = 0
    var max_y = 0
    
    var players = get_node("/root/Game/Players").get_children()
    
    if players.size() == 1:
        return Vector2(players[0].position.x, players[0].position.y)