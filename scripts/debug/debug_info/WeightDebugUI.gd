class_name WeightDebugUI
extends Control

@export var weight: Weight
@onready var label = $Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "%s" % weight.get_total_weight()
