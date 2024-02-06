extends Control

class_name Transitioner
@export var scene_switch_anim : String = "Fade_out"
@export var scene_to_load : PackedScene
@onready var animation_tex : TextureRect = $TextureRect
@export var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.queue("Fade_in")
	

	
func _on_animation_player_animation_finished(anim_name):
	if(scene_to_load != null && anim_name == scene_switch_anim):
		get_tree().change_scene_to_packed(scene_to_load)	
		
func changeScene():
	animation_player.play("Fade_out")
	
