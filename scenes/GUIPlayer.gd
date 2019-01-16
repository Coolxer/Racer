extends HBoxContainer

func update_position():
    $Position.text = str(get_index() + 1) + "."

func set_nickname(nickname):
    $Name.text = nickname
    
func set_round(current, all):
    $RoundText.text = str(current) + "/" + str(all)

func set_checkpoint(current, all):
    $CheckpointText.text = str(current) + "/" + str(all)