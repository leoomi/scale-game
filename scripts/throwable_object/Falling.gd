extends ThrowableObjectState

func physics_update(delta):
	if t_object.is_on_floor():
		t_object.handle_collisions_on_bottom()
		t_object.velocity = Vector2.ZERO
		t_object.fsm.transition_to("Idle")

	t_object.apply_gravity(delta)
	t_object.move_and_slide()
