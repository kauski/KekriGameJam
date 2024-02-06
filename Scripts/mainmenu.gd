extends Control

func _on_start_button_pressed():
	get_node("../Transitions").changeScene()
#	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")

func _on_credits_pressed():
	var credits = preload("res://Scenes/Credits.tscn").instantiate()
	visible = false
	get_tree().get_root().add_child(credits)

func _on_quit_button_pressed():
	get_tree().quit()



