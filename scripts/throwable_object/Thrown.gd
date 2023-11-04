extends ThrowableObjectState

var first_frame: bool

func enter(_msg = {}):
	first_frame = true

func physics_update(delta):
	if not first_frame and t_object.is_on_floor():
		t_object.velocity = Vector2.ZERO
		t_object.fsm.transition_to("Idle")

	t_object.apply_gravity(delta)
	t_object.move_and_slide()
	first_frame = false
