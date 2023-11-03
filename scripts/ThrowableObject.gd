class_name ThrowableObject
extends CharacterBody2D

@export var max_fall_velocity = 250.0
@export var debug = false
@onready var weight: Weight = $Weight
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var weights_on_top = []

signal weight_potentially_removed(weight: Weight)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	weight.handle_collisions_on_bottom()
	velocity.y = move_toward(velocity.y, max_fall_velocity, delta * gravity)
	move_and_slide()
