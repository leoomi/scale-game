class_name ThrowableObject
extends CharacterBody2D

@export var max_fall_velocity = 250.0
@export var debug = false
@export var throw_velocity = Vector2(200, -200)
@export var weight_value: int = 1
@onready var weight: Weight = $Weight
@onready var fsm: StateMachine = $StateMachine
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var area: Area2D = $Area2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var weights_on_top = []
var current_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	weight.weight = weight_value

func handle_collisions_on_bottom():
	weight.handle_collisions_on_bottom()

func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_velocity, delta * gravity)

func handle_interaction(player: Player):
	collision_shape.disabled = true
	player.pickup_transform.set_remote_node(self.get_path())
	player.picked_up_object = self
	player.weight.weights_on_top = [weight]
	player.weight.weight_changed.emit(player.weight.weights_on_top)
	weight.on_weight_picked_up()

	if current_tween != null and current_tween.is_running():
		current_tween.kill()
	fsm.transition_to("PickedUp")

func handle_picked_up_interaction(player: Player):
	if area.has_overlapping_areas() or area.has_overlapping_bodies():
		return

	collision_shape.disabled = false
	player.picked_up_object = null
	player.pickup_transform.set_remote_node("")
	player.weight.weights_on_top = []
	player.weight.weight_changed.emit([])
	velocity = throw_velocity
	velocity.x = player.transform.x.x * velocity.x
	transform.x.x = 1
	
	if current_tween != null and current_tween.is_running():
		current_tween.kill()
	fsm.transition_to("Thrown")

func on_plate_moved(movement: float, duration: float):
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC)
	var vector = Vector2(0, movement)
	tween.tween_property(self, "position", position + vector, duration)
	current_tween = tween

func should_idle():
	if not is_on_floor():
		return false

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider is Plate:
			var plate = collider as Plate
			if plate.current_tween == null or not plate.current_tween.is_running():
				return true

	return false

func play_fall_sound():
	$SFX.play()
