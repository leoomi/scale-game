class_name ScaleDebugUI
extends Control

@export var scale_object: Scale
@onready var label = $Label

func _ready():
	if not OS.is_debug_build():
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label.text = "%s" % scale_object.current_difference
