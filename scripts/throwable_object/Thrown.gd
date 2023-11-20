extends ThrowableObjectState

var first_frame: bool

func enter(_msg = {}):
	first_frame = true

func physics_update(delta):
	if should_idle():
		t_object.velocity = Vector2.ZERO
		t_object.fsm.transition_to("Idle")

	if should_fall():
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
			print(self, collider)
			if collider is Plate:
				return true

	return false

func should_fall():
	if first_frame or not t_object.is_on_floor():
		return false

	for i in t_object.get_slide_collision_count():
			var collision = t_object.get_slide_collision(i)
			var collider = collision.get_collider()
			print(self, collider)
			if not collider is Plate:
				return true

	return false
