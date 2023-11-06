extends PlayerState

var fast_falling = false ## This could be a state but holy shit I've done this way too much

func enter(_msg := {}) -> void:
	player.animation.play("falling")
	fast_falling = false

func physics_update(delta: float):
	player.check_grounded_state()

	var direction = Input.get_axis("move_left", "move_right")
	if player.inventory.wall_slide and player.is_touching_wall(direction):
		state_machine.transition_to("WallSliding")

	if Input.is_action_just_pressed("down"):
		fast_falling = true
		player.velocity.y = player.fast_fall_velocity

	if not fast_falling:
		player.apply_gravity(delta)

	player.handle_horizontal_movement(direction, delta)
	var double_jumped = player.handle_wall_jump(direction)
	
	if !double_jumped:
		player.handle_double_jump()

	player.handle_collisions_on_bottom()

	player.handle_interactions()

	player.move_and_slide()

