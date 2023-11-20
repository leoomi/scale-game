extends ThrowableObjectState

var first_frame = false

func enter(msg = {}):
	first_frame = true

func physics_update(delta):
	if first_frame:
		first_frame = false
		return

	if t_object.should_idle():
		t_object.velocity = Vector2.ZERO
		t_object.fsm.transition_to("Idle")

	t_object.handle_collisions_on_bottom()
	t_object.apply_gravity(delta)
	t_object.move_and_slide()
