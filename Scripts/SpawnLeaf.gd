extends Node3D


var leaf
var stick
var squirrel


func _spawn_leaf(pos):
	var leafsc = preload("res://Scenes/Kapy/kapy.tscn")
	var sticksc = preload("res://Scenes/Oksa/oksa.tscn")
	var squirrelsc = preload("res://Scenes/Kurre/kurre.tscn")
#	var SpawnPosNode = get_node("Tree/LeafSpawnPosition")
	var SpawnPosNode = get_node("../LeafSpawnPosition")
	if SpawnPosNode:
		
		var SpawnPos = SpawnPosNode.get_position()
		var randomx = 0.0
		var randomz = 0.0
		while randomx >= -0.4 && randomx <= 0.4:
			randomx = randf_range(-1.0, 1.0)
		while randomz >= -0.4 && randomz <= 0.4:
			randomz = randf_range(-1.0, 1.0)
		
		SpawnPos.x += randomx + pos.x
		SpawnPos.z += randomz + pos.z
		var random = randi() % 3
		print(random)
		if random == 0:
			stick = sticksc.instantiate()
			stick.position = SpawnPos
#			add_child(stick)
			get_tree().get_root().get_node("/root/Level1").add_child(stick)
			
			
		if random == 1:
			squirrel = squirrelsc.instantiate()
			squirrel.position = SpawnPos
#			add_child(squirrel)
			get_tree().get_root().get_node("/root/Level1").add_child(squirrel)
			
			
		else:
			leaf = leafsc.instantiate()
			leaf.position = SpawnPos
#			add_child(leaf)
			get_tree().get_root().get_node("/root/Level1").add_child(leaf)
