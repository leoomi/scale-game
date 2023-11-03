extends PlayerState

func enter(msg := {}) -> void:
	player.animation.play("jumping")
	player.flip(msg.direction)
	player.wall_jump(msg.direction)

	await get_tree().create_timer(8 * 0.01667).timeout
	if not player.fsm.state.name == self.name:
		return

	state_machine.transition_to("Jumping")

func physics_update(delta: float):
	if player.velocity.y >= 0 || player.is_on_ceiling():
		state_machine.transition_to("Falling")

	player.apply_gravity(delta)

	player.handle_collisions_on_bottom()

	player.move_and_slide()
