class_name Scale
extends Node2D

@export var move_distance = 20
@export var left_plate: Plate
@export var right_plate: Plate
var current_difference = 0
var current_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	left_plate.weight.weight_changed.connect(on_weights_changed)
	right_plate.weight.weight_changed.connect(on_weights_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_difference() -> int:
	return right_plate.weight.get_total_weight() - left_plate.weight.get_total_weight()

func on_weights_changed(_weights):
	if current_tween != null and current_tween.is_running():
		return

	check_and_move_plates()

func check_and_move_plates():
	var new_diff = get_difference()
	var old_diff = current_difference
	var weight_delta = new_diff - old_diff
	current_difference = new_diff
	
	if weight_delta == 0:
		return

	current_tween = move_plates(weight_delta)
	current_tween.tween_callback(check_and_move_plates)

## Clean this shit up later. Maybe add an impulse for the player object
func move_plates(weight_delta: int) -> Tween:
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC)
	var up = Vector2(0, weight_delta * -15)
	tween.tween_property(left_plate, "position", left_plate.position + up, 0.5)
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC)
	var down = Vector2(0, weight_delta * 15)
	tween.tween_property(right_plate, "position", right_plate.position + down, 0.5)
	
	return tween
	
	
