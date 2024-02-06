extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_timer_timeout():
	var ShitsOnFire = false
	for i in get_tree().get_nodes_in_group("Halko"):
		i = i as Halko
		if i.Burning == true:
			ShitsOnFire = true
			break
	if ShitsOnFire == true && playing == false:
		play()
	if ShitsOnFire == false && playing == true:
		stop()
