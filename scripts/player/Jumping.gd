extends PlayerState

var first_frame = false

func enter(msg := {}) -> void:
	player.animation.play("jumping")

	first_frame = true

func physics_update(delta: float):
	if not first_frame:
		player.check_grounded_state()

	if player.velocity.y >= 0:
		state_machine.transition_to("Falling")

	player.apply_gravity(delta)
	
	var direction = Input.get_axis("move_left", "move_right")

	player.handle_horizontal_movement(direction, delta)
	var double_jumped = player.handle_wall_jump(direction)
	
	if !double_jumped:
		player.handle_double_jump()

	player.handle_collisions_on_bottom()

	player.move_and_slide()

	first_frame = false
