class_name Plate
extends CharacterBody2D

@export var weight_value: int = 1
@onready var weight: Weight = $Weight
var current_tween: Tween

func _ready():
	weight.weight = weight_value

func move_plate(difference: int, movement: float, duration: float) -> Tween:
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CUBIC)
	current_tween = tween
	var vector = Vector2(0, movement)
	tween.tween_property(self, "position", position + vector, duration)

	if movement < 0:
		get_tree().create_timer(0.75*duration).timeout.connect(func(): check_player(difference))

	for w in weight.weights_on_top:
		if w.owner is ThrowableObject:
			var throwable_object = w.owner as ThrowableObject
			if not throwable_object is ThrowableObjectIdle:
				throwable_object.on_plate_moved(movement, duration)

	return tween

func check_player(magnitude: int):
	for w in weight.weights_on_top:
		if w.owner is Player:
			var player: Player = w.owner
			player.scale_jump(abs(magnitude))
