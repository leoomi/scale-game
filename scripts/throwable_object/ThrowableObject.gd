class_name ThrowableObject
extends CharacterBody2D

@export var max_fall_velocity = 250.0
@export var debug = false
@export var throw_velocity = Vector2(200, -200)
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

func handle_interaction(player: Player):
	player.pickup_transform.set_remote_node(self.get_path())
	player.picked_up_object = self
	fsm.transition_to("PickedUp")

func handle_picked_up_interaction(player: Player):
	player.picked_up_object = null
	player.pickup_transform.set_remote_node("")
	velocity = throw_velocity
	velocity.x = player.transform.x.x * velocity.x
	fsm.transition_to("Thrown")
