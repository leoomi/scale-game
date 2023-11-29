class_name Weight
extends Node

@export var weight: int = 1
@onready var character_body: CharacterBody2D = owner
var weights_on_top = []

signal weight_potentially_removed(weight: Weight)
signal weight_changed(weight: Weight)

func handle_collisions_on_bottom():
	if not owner.is_on_floor():
		weight_potentially_removed.emit(self)
		return

	for i in range(owner.get_slide_collision_count()):
		var collision = owner.get_slide_collision(i)
		var collider = collision.get_collider()

		if sign(collision.get_normal().y) != -1:
			continue

		if collider.is_in_group("Weight") or collider.is_in_group("Plate"):
			collider.weight.add_weight_objects([self])

func add_weight_objects(weights):
	for weight in weights:
		var changed = false
		if not weights_on_top.has(weight):
			weights_on_top.append(weight)
			weight.weight_potentially_removed.connect(on_weight_potentially_removed)
			weight.weight_changed.connect(on_weight_changed)
			changed = true

		if changed:
			weight_changed.emit(weights)

func get_total_weight() -> int:
	var total_weight = weight
	
	for weight in weights_on_top:
		if weight.owner is Player:
			total_weight += weight.get_total_weight()
		else:
			total_weight += weight.weight
		
	return total_weight

func on_weight_potentially_removed(weight: Weight):
	weights_on_top.erase(weight)
	weight_changed.emit(weights_on_top)
	var removed_signal = weight.weight_potentially_removed as Signal

	if removed_signal.is_connected(on_weight_potentially_removed):
		removed_signal.disconnect(on_weight_potentially_removed)
		weight.weight_changed.disconnect(on_weight_changed)

func on_weight_changed(weights):
	add_weight_objects(weights)

func on_weight_picked_up():
	for w in weights_on_top:
		if w.owner is ThrowableObject:
			var throwable_object = w.owner as ThrowableObject
			throwable_object.fsm.transition_to("Falling")

	weights_on_top = []
	weight_potentially_removed.emit(self)
	
