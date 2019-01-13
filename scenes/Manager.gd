extends Node

export var scenes = {
    "menu": "res://scenes/Menu.tscn",
    "configuration": "res://scenes/Configuration.tscn",
    "game": "res://scenes/Game.tscn"
}

export var tracks = {
    "Track1": "res://scenes/tracks/Track1.tscn",
    "Track2": "res://scenes/tracks/Track2.tscn"
}

export var cars = {
    "Car1": "res://scenes/cars/Car1.tscn",
    "Car2": "res://scenes/cars/Car2.tscn",
    "Car3": "res://scenes/cars/Car3.tscn"
}

export var keys = [
    {
        "up": "up_1",
        "left": "left_1",
        "down": "down_1",
        "right": "right_1"    
    },
    {
        "up": "up_2",
        "left": "left_2",
        "down": "down_2",
        "right": "right_2"    
    },
    {
        "up": "up_3",
        "left": "left_3",
        "down": "down_3",
        "right": "right_3"    
    }
]

var current_scene = null
var scene_loaded = false

var track_scene = null
var car_scenes = []
var round_amount = 0

func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() -1)
        
func load_scene(path):
    scene_loaded = false
    call_deferred("_deferred_goto_scene", path)

func menu():
    load_scene(Manager.scenes["menu"])

func configure():
    load_scene(Manager.scenes["configuration"])
    
func game(track, players, rounds):
    track_scene = load(tracks[track])
    
    for player in players:
        car_scenes.append(load(cars[player]))
        
    round_amount = rounds
    
    load_scene(Manager.scenes["game"])

func _deferred_goto_scene(path):
    current_scene.free()
    var scene = ResourceLoader.load(path)
    current_scene = scene.instance()
	
    get_tree().get_root().add_child(current_scene)
    get_tree().set_current_scene(current_scene)
    
    scene_loaded = true