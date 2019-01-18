extends HBoxContainer

func update_position():
    $Position.text = str(get_index() + 1) + "."

func get_nickname():
    return $Name.text

func set_nickname(nickname):
    $Name.text = nickname
    
func set_round(current, all):
    $RoundText.text = str(current) + "/" + str(all)

func set_checkpoint(current, all):
    $CheckpointText.text = str(current) + "/" + str(all)
    
func change_color(color):
    $Position.add_color_override("font_color", color)
    $Name.add_color_override("font_color", color)
    $CheckpointText.add_color_override("font_color", color)
    $RoundText.add_color_override("font_color", color)