extends Scale

@export var current_state = false
signal switch_changed(state: bool)

func _on_movement_done():
	var is_equal = get_difference() == 0
	var activated = false

	if is_equal and (left_plate.weight.weights_on_top.size() > 0 or right_plate.weight.weights_on_top.size() > 0):
		activated = true

	if activated and !current_state:
		current_state = true
		switch_changed.emit(current_state)
	elif not activated and current_state:
		current_state = false
		switch_changed.emit(current_state)
