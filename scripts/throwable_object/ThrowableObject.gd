class_name ThrowableObject
extends CharacterBody2D

@export var max_fall_velocity = 250.0
@export var debug = false
@export var throw_velocity = Vector2(200, -200)
@export var weight_value: int = 1
@onready var weight: Weight = $Weight
@onready var fsm: StateMachine = $StateMachine
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var weights_on_top = []

# Called when the node enters the scene tree for the first time.
func _ready():
	weight.weight = weight_value

func handle_collisions_on_bottom():
	weight.handle_collisions_on_bottom()

func apply_gravity(delta: float):
	velocity.y = move_toward(velocity.y, max_fall_velocity, delta * gravity)

func handle_interaction(player: Player):
	collision_shape.disabled = true
	player.pickup_transform.set_remote_node(self.get_path())
	player.picked_up_object = self
	player.weight.weights_on_top = [weight]
	player.weight.weight_changed.emit(player.weight.weights_on_top)
	weight.on_weight_picked_up()
	fsm.transition_to("PickedUp")

func handle_picked_up_interaction(player: Player):
	collision_shape.disabled = false
	player.picked_up_object = null
	player.pickup_transform.set_remote_node("")
	player.weight.weights_on_top = []
	player.weight.weight_changed.emit([])
	velocity = throw_velocity
	velocity.x = player.transform.x.x * velocity.x
	transform.x.x = 1
	fsm.transition_to("Thrown")
