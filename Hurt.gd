class_name Hurt
extends PlayerState

func enter(_msg := {}) -> void:
	player.animation.play("hurt")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	if player.is_on_floor():
		player.velocity = Vector2.ZERO
		player.fsm.transition_to("Idle")

	player.apply_gravity(delta)

	player.move_and_slide()
