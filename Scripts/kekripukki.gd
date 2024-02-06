class_name KekriPukki
extends RigidBody3D

@export var SPEEED = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(_delta):
	linear_velocity.x = SPEEED


