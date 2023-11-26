extends CharacterBody2D

@export var movement_delta: float = 64
var initial_position: Vector2
var current_state = false
var current_tween: Tween

func _ready():
	initial_position = position

func _on_switch_scale_switch_changed(state):
	if state == current_state:
		return

	current_state = state
	if current_state:
		open()
	else:
		close()

func open():
	if current_tween != null && current_tween.is_running():
		current_tween.stop()
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC)
	current_tween = tween
	tween.tween_property(self, "position", initial_position + Vector2(0, -movement_delta), 0.5)
	
func close():
	if current_tween != null && current_tween.is_running():
		current_tween.stop()
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC)
	current_tween = tween
	tween.tween_property(self, "position", initial_position, 0.5)
