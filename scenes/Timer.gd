extends VBoxContainer

#Timestamp when game was started (or resumed when pause will be implemented)
var start_time = 0
var label_node

func _ready():
    label_node = $Label

func start():
    start_time = OS.get_unix_time()
    
func update():
    var current_time = OS.get_unix_time()
    var elapsed = current_time - start_time
    
    var minutes = elapsed / 60
    var seconds = elapsed % 60
    var text = "%02d : %02d" % [minutes, seconds]
    
    label_node.text = text