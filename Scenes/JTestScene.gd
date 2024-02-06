extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_leaf_spawn_timer_timeout():
	var leafsc = preload("res://Scenes/leaf_scene.tscn")
	var leaf = leafsc.instantiate()
	var SpawnPosNode = get_node("Tree/LeafSpawnPosition")
	if SpawnPosNode:
		var SpawnPos = SpawnPosNode.get_position()
		leaf.transform.origin = SpawnPos
		add_child(leaf)
	
	
	
	
	



