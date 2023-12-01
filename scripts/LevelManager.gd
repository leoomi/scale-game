extends Node2D

@export var music_path = "res://assets/sounds/Forest.wav"

func _ready():
	Music.on_scene_changed(music_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
 
