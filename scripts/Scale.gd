class_name Scale
extends Node2D

@export var move_distance = 20
@export var left_plate: Plate
@export var right_plate: Plate
var current_difference = 0
var current_tween: Tween
signal movement_done

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
	current_tween.tween_callback(movement_tween_callback)

## Clean this shit up later. Maybe add an impulse for the player object
func move_plates(weight_delta: int) -> Tween:
	var tween = left_plate.move_plate(-weight_delta, weight_delta * -move_distance, 0.5)
	right_plate.move_plate(weight_delta, weight_delta * move_distance, 0.5)
	
	return tween

func movement_tween_callback():
	check_and_move_plates()
	movement_done.emit()
