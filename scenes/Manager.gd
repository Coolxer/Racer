extends Node

export var scenes = {
    "menu": "res://scenes/Menu.tscn",
    "configuration": "res://scenes/Configuration.tscn"
}

var current_scene = null

func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() -1)
        
func load_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
    current_scene.free()
    var scene = ResourceLoader.load(path)
    current_scene = scene.instance()
	
    get_tree().get_root().add_child(current_scene)
    get_tree().set_current_scene(current_scene)