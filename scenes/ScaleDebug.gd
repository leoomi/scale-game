class_name ScaleDebugUI
extends Control

@export var scale_object: Scale
@onready var label = $Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "%s" % scale_object.get_difference()
