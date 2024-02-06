extends Node3D

@export var SpawnIntervalMinSec = 30.0
@export var SpawnIntervalMaxSec = 90.0
@export var PukkiPackedScene : PackedScene
@export var MirrorSpawning : bool = false
var WarningAnnounced : bool = false


func _ready():
	$Timer.wait_time = randf_range(SpawnIntervalMinSec,SpawnIntervalMaxSec)
	$Timer.start()

func _process(delta):
	if $Timer.time_left < 7 && WarningAnnounced == false:
		$WarningSound.play()
		WarningAnnounced = true

func _on_timer_timeout():
	WarningAnnounced = false # Reset flag
	var newPukki = PukkiPackedScene.instantiate() as KekriPukki
	self.add_child(newPukki)
	if MirrorSpawning:
		newPukki.global_rotation_degrees.y += 180
		newPukki.SPEEED *= -1
	$Timer.wait_time = randf_range(SpawnIntervalMinSec,SpawnIntervalMaxSec)
	$Timer.start()
