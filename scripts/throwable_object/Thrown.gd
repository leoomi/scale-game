extends ThrowableObjectState

var first_frame: bool

func enter(_msg = {}):
	first_frame = true

func physics_update(delta):
	if should_idle():
		t_object.play_fall_sound()
		t_object.velocity = Vector2.ZERO
		t_object.fsm.transition_to("Idle")

	if should_fall():
		t_object.play_fall_sound()
		t_object.velocity = Vector2.ZERO
		t_object.fsm.transition_to("Falling")

	t_object.apply_gravity(delta)
	t_object.move_and_slide()
	first_frame = false

func should_idle():
	if first_frame or not t_object.is_on_floor():
		return false

	for i in t_object.get_slide_collision_count():
			var collision = t_object.get_slide_collision(i)
			var collider = collision.get_collider()
			if not collider is Plate:
				continue
			var plate: Plate = collider
			if plate.current_tween == null or not plate.current_tween.is_running():
				return true

	return false

func should_fall():
	if first_frame or not t_object.is_on_floor():
		return false

	for i in t_object.get_slide_collision_count():
			var collision = t_object.get_slide_collision(i)
			var collider = collision.get_collider()
			if not collider is Plate:
				return true
			else:
				var plate: Plate = collider
				if plate.current_tween == null or plate.current_tween.is_running():
					return true

	return false
