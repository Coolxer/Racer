extends HBoxContainer

var selected = ""

func _on_Track_pressed(index):
    selected = get_child(index).name
    _unselect_all_but_one(index)

func _unselect_all_but_one(index):
    for track in get_children():
        if track.get_index() != index:
            track.pressed = false