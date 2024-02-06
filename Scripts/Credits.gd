extends Control


func _on_back_pressed():
	queue_free()
	get_node("../Main/mainmenu").visible = true
