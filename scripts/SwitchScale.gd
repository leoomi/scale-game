extends Scale

@export var current_state = false
signal switch_changed(state: bool)

func _on_movement_done():
	if get_difference() == 0 && !current_state:
		current_state = true
		switch_changed.emit(current_state)
	elif get_difference() != 0 && current_state:
		current_state = false
		switch_changed.emit(current_state)
