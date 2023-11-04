class_name ThrowableObject
extends CharacterBody2D

@export var max_fall_velocity = 250.0
@export var debug = false
@onready var weight: Weight = $Weight
@onready var fsm: StateMachine = $StateMachine
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var weights_on_top = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func handle_collisions_on_bottom():
	weight.handle_collisions_on_bottom()

func apply_gravity(delta: float):
	velocity.y = move_toward(velocity.y, max_fall_velocity, delta * gravity)
