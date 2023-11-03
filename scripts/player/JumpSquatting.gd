extends PlayerState

const animation_name = "jump_squatting"

func enter(_msg := {}) -> void:
	player.animation.play(animation_name)

func physics_update(delta: float):
	player.handle_collisions_on_bottom()
	player.move_and_slide()

func _on_animation_player_animation_finished(anim_name):
	if not anim_name == animation_name:
		return

	var long_jump = Input.is_action_pressed("jump")
	if long_jump and player.inventory.long_jump:
		player.long_jump()
	else:
		player.short_hop()

	state_machine.transition_to("Jumping")
