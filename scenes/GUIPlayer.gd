extends HBoxContainer

func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass

func set_nickname(nickname):
    $Name.text = nickname
    
func set_round(current, all):
    $RoundText.text = str(current) + "/" + str(all)

func set_checkpoint(current, all):
    $CheckpointText.text = str(current) + "/" + str(all)