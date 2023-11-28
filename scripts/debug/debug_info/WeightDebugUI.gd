class_name WeightDebugUI
extends Control

@export var weight: Weight
@onready var label = $Label

func _ready():
	if not OS.is_debug_build():
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "%s" % weight.get_total_weight()
