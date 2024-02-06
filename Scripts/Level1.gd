extends Node3D

func _physics_process(delta):
	var hasBurningHalko = false
	for i in get_tree().get_nodes_in_group("Halko"):
		i = i as Halko
		if i.Burning:
			hasBurningHalko = true
			break
	if hasBurningHalko == false:
		Manager._lose_screen()
